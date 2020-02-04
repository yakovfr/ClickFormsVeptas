unit Apex_Integration_TLB;

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
// File generated on 6/22/2015 10:43:40 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Apex Software\Apex Sketch\Library\Apex.Integration.tlb (1)
// LIBID: {028F32B0-E185-4F17-B8FC-0C4821486744}
// LCID: 0
// Helpfile: 
// HelpString: Apex Sketch Integration Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
//   (3) v2.0 System, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.tlb)
//   (4) v2.0 System_Windows_Forms, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Windows.Forms.tlb)
// Errors:
//   Error creating palette bitmap of (TApexSketch) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSketchClient) : Server mscoree.dll contains no icons
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

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, System_TLB, 
System_Windows_Forms_TLB, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Apex_IntegrationMajorVersion = 1;
  Apex_IntegrationMinorVersion = 6;

  LIBID_Apex_Integration: TGUID = '{028F32B0-E185-4F17-B8FC-0C4821486744}';

  IID_ISketchClient: TGUID = '{7EE40959-4D4C-41B4-A807-4DE9E0848A80}';
  IID__ApexSketch: TGUID = '{41C67700-D3FF-3A47-BF20-745AB30E8FFA}';
  IID_IBreakdownShape: TGUID = '{B0143B97-96A9-4EBB-B222-1F9934904B06}';
  CLASS_BreakdownShape: TGUID = '{B61E90CA-3075-32AE-BFD1-0D0D6E476E00}';
  IID_IAreaBreakdown: TGUID = '{B07596D6-9182-406D-B9EA-5D270B0EF4A4}';
  CLASS_AreaBreakDown: TGUID = '{7CB07F13-9629-31DF-960C-7B1E6CFBF226}';
  IID_IArea: TGUID = '{0807E7C7-8766-4D20-B8C2-BDA53234F821}';
  CLASS_Area: TGUID = '{9DA96E48-5847-3C4A-A989-CB4320F8A0E8}';
  IID_ITag: TGUID = '{7475C158-CD2B-44BE-92B9-342A2B0B2933}';
  IID_ITagCollection: TGUID = '{292FEBD4-38E2-46D4-8F4C-FB698300C6E5}';
  CLASS_ProxyTag: TGUID = '{031B5CDD-817C-3577-BA37-C0DB236D3BF7}';
  CLASS_TagCollection: TGUID = '{BAD33197-4EF3-3996-9442-9DDD36ACB0F4}';
  IID_IGeoReferencePoint: TGUID = '{3FE5D998-8890-4D20-A845-B92A61E1A19E}';
  CLASS_GeoReferencePoint: TGUID = '{DF99419B-DE94-3D7C-813A-F1295C656A28}';
  IID_IGeoReferencePointCollection: TGUID = '{53EAF615-A6CE-49A4-818F-B38D13FDB001}';
  CLASS_GeoReferencePointCollection: TGUID = '{7F0E13E3-8BB9-3458-A25C-8060E545C5DC}';
  IID_IPage: TGUID = '{51361433-B9FC-4A4C-A7FD-050014487E47}';
  IID__SymbolEventArgs: TGUID = '{D547668F-9702-39E1-90BD-FF8B487C5756}';
  IID__SketchItemEventArgs: TGUID = '{697816F7-7CBC-3824-AC07-7BB83E8061D8}';
  IID_ISketch: TGUID = '{DADD945B-1C2A-416E-80CB-0B05444E13A4}';
  DIID_ISketchClientEvents: TGUID = '{22C11A2D-8057-4674-8E76-19C0C2720033}';
  IID_ISubject: TGUID = '{B17C1D0B-D1A5-46A3-91FA-91641D3E4AD5}';
  CLASS_Page: TGUID = '{AE28C755-75DE-3828-B555-3FB044C5CDC4}';
  CLASS_Sketch: TGUID = '{12E8D8AF-18A0-3EE4-85D5-BA09C14ADCB0}';
  IID__SketchClient: TGUID = '{25F90085-8250-3B13-B969-097E85991906}';
  CLASS_Subject: TGUID = '{ECB3A80E-CFED-38A3-9055-3076AC4F2AB9}';
  CLASS_ApexSketch: TGUID = '{8665AC21-01AE-4156-90F0-EA54DF1CB6E2}';
  CLASS_SymbolEventArgs: TGUID = '{1E6AC838-0E87-48A1-A1B8-78BC200B974D}';
  CLASS_SketchItemEventArgs: TGUID = '{85C2C1FF-5457-4758-B7A5-69FD77F19CE7}';
  CLASS_SketchClient: TGUID = '{8336A4AA-E39C-487E-A34C-BC451F6E4775}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISketchClient = interface;
  ISketchClientDisp = dispinterface;
  _ApexSketch = interface;
  _ApexSketchDisp = dispinterface;
  IBreakdownShape = interface;
  IBreakdownShapeDisp = dispinterface;
  IAreaBreakdown = interface;
  IAreaBreakdownDisp = dispinterface;
  IArea = interface;
  IAreaDisp = dispinterface;
  ITag = interface;
  ITagDisp = dispinterface;
  ITagCollection = interface;
  ITagCollectionDisp = dispinterface;
  IGeoReferencePoint = interface;
  IGeoReferencePointDisp = dispinterface;
  IGeoReferencePointCollection = interface;
  IGeoReferencePointCollectionDisp = dispinterface;
  IPage = interface;
  IPageDisp = dispinterface;
  _SymbolEventArgs = interface;
  _SymbolEventArgsDisp = dispinterface;
  _SketchItemEventArgs = interface;
  _SketchItemEventArgsDisp = dispinterface;
  ISketch = interface;
  ISketchDisp = dispinterface;
  ISketchClientEvents = dispinterface;
  ISubject = interface;
  ISubjectDisp = dispinterface;
  _SketchClient = interface;
  _SketchClientDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BreakdownShape = IBreakdownShape;
  AreaBreakDown = IAreaBreakdown;
  Area = IArea;
  ProxyTag = ITag;
  TagCollection = ITagCollection;
  GeoReferencePoint = IGeoReferencePoint;
  GeoReferencePointCollection = IGeoReferencePointCollection;
  Page = IPage;
  Sketch = ISketch;
  Subject = ISubject;
  ApexSketch = ISketchClient;
  SymbolEventArgs = _SymbolEventArgs;
  SketchItemEventArgs = _SketchItemEventArgs;
  SketchClient = ISketchClient;


// *********************************************************************//
// Interface: ISketchClient
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7EE40959-4D4C-41B4-A807-4DE9E0848A80}
// *********************************************************************//
  ISketchClient = interface(IDispatch)
    ['{7EE40959-4D4C-41B4-A807-4DE9E0848A80}']
    function Get_Sketch: ISketch; safecall;
    procedure Exit; safecall;
    function New: ISketch; safecall;
    function NewAs(const path: WideString): ISketch; safecall;
    function Open(const path: WideString): ISketch; safecall;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch; safecall;
    function OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch; safecall;
    function SaveAsBase64String: WideString; safecall;
    procedure ExportPageImages(const path: WideString; const options: WideString); safecall;
    function Get_AreaCodeTableUrl: WideString; safecall;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString); safecall;
    function Get_IsAppRunning: WordBool; safecall;
    function Get_AppPath: WideString; safecall;
    property Sketch: ISketch read Get_Sketch;
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
    property IsAppRunning: WordBool read Get_IsAppRunning;
    property AppPath: WideString read Get_AppPath;
  end;

// *********************************************************************//
// DispIntf:  ISketchClientDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7EE40959-4D4C-41B4-A807-4DE9E0848A80}
// *********************************************************************//
  ISketchClientDisp = dispinterface
    ['{7EE40959-4D4C-41B4-A807-4DE9E0848A80}']
    property Sketch: ISketch readonly dispid 1610743808;
    procedure Exit; dispid 1610743809;
    function New: ISketch; dispid 1610743810;
    function NewAs(const path: WideString): ISketch; dispid 1610743811;
    function Open(const path: WideString): ISketch; dispid 1610743812;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch; dispid 1610743813;
    function OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch; dispid 1610743814;
    function SaveAsBase64String: WideString; dispid 1610743815;
    procedure ExportPageImages(const path: WideString; const options: WideString); dispid 1610743816;
    property AreaCodeTableUrl: WideString dispid 1610743817;
    property IsAppRunning: WordBool readonly dispid 1610743819;
    property AppPath: WideString readonly dispid 1610743820;
  end;

// *********************************************************************//
// Interface: _ApexSketch
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {41C67700-D3FF-3A47-BF20-745AB30E8FFA}
// *********************************************************************//
  _ApexSketch = interface(IDispatch)
    ['{41C67700-D3FF-3A47-BF20-745AB30E8FFA}']
    function Get_ToString: WideString; safecall;
    function Equals(obj: OleVariant): WordBool; safecall;
    function GetHashCode: Integer; safecall;
    function GetType: _Type; safecall;
    function Get_Sketch: ISketch; safecall;
    procedure Exit; safecall;
    function New: ISketch; safecall;
    function NewAs(const name: WideString): ISketch; safecall;
    function Open(const path: WideString): ISketch; safecall;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch; safecall;
    function OpenFromBase64String(const base64String: WideString; pageIndex: Integer): ISketch; safecall;
    function SaveAsBase64String: WideString; safecall;
    procedure ExportPageImages(const path: WideString; const options: WideString); safecall;
    function Get_AreaCodeTableUrl: WideString; safecall;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString); safecall;
    function Get_IsAppRunning: WordBool; safecall;
    function Get_AppPath: WideString; safecall;
    procedure Dispose; safecall;
    function Get_IsDisposed: WordBool; safecall;
    procedure add_ApplicationClosed(const value: _EventHandler); safecall;
    procedure remove_ApplicationClosed(const value: _EventHandler); safecall;
    procedure add_ApplicationClosing(const value: IUnknown); safecall;
    procedure remove_ApplicationClosing(const value: IUnknown); safecall;
    procedure add_SketchClosed(const value: _EventHandler); safecall;
    procedure remove_SketchClosed(const value: _EventHandler); safecall;
    procedure add_SketchClosing(const value: IUnknown); safecall;
    procedure remove_SketchClosing(const value: IUnknown); safecall;
    procedure add_SketchLoaded(const value: _EventHandler); safecall;
    procedure remove_SketchLoaded(const value: _EventHandler); safecall;
    procedure add_SketchModified(const value: _EventHandler); safecall;
    procedure remove_SketchModified(const value: _EventHandler); safecall;
    procedure add_SketchSaved(const value: _EventHandler); safecall;
    procedure remove_SketchSaved(const value: _EventHandler); safecall;
    procedure add_PageChanged(const value: _EventHandler); safecall;
    procedure remove_PageChanged(const value: _EventHandler); safecall;
    procedure add_SymbolAdded(const value: IUnknown); safecall;
    procedure remove_SymbolAdded(const value: IUnknown); safecall;
    procedure add_SymbolRemoved(const value: IUnknown); safecall;
    procedure remove_SymbolRemoved(const value: IUnknown); safecall;
    procedure add_AreaAdded(const value: IUnknown); safecall;
    procedure remove_AreaAdded(const value: IUnknown); safecall;
    procedure add_AreaRemoved(const value: IUnknown); safecall;
    procedure remove_AreaRemoved(const value: IUnknown); safecall;
    procedure add_AreaChanged(const value: IUnknown); safecall;
    procedure remove_AreaChanged(const value: IUnknown); safecall;
    procedure add_GeoReferencePointsPlaced(const value: IUnknown); safecall;
    procedure remove_GeoReferencePointsPlaced(const value: IUnknown); safecall;
    property ToString: WideString read Get_ToString;
    property Sketch: ISketch read Get_Sketch;
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
    property IsAppRunning: WordBool read Get_IsAppRunning;
    property AppPath: WideString read Get_AppPath;
    property IsDisposed: WordBool read Get_IsDisposed;
  end;

// *********************************************************************//
// DispIntf:  _ApexSketchDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {41C67700-D3FF-3A47-BF20-745AB30E8FFA}
// *********************************************************************//
  _ApexSketchDisp = dispinterface
    ['{41C67700-D3FF-3A47-BF20-745AB30E8FFA}']
    property ToString: WideString readonly dispid 0;
    function Equals(obj: OleVariant): WordBool; dispid 1610743809;
    function GetHashCode: Integer; dispid 1610743810;
    function GetType: _Type; dispid 1610743811;
    property Sketch: ISketch readonly dispid 1610743812;
    procedure Exit; dispid 1610743813;
    function New: ISketch; dispid 1610743814;
    function NewAs(const name: WideString): ISketch; dispid 1610743815;
    function Open(const path: WideString): ISketch; dispid 1610743816;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch; dispid 1610743817;
    function OpenFromBase64String(const base64String: WideString; pageIndex: Integer): ISketch; dispid 1610743818;
    function SaveAsBase64String: WideString; dispid 1610743819;
    procedure ExportPageImages(const path: WideString; const options: WideString); dispid 1610743820;
    property AreaCodeTableUrl: WideString dispid 1610743821;
    property IsAppRunning: WordBool readonly dispid 1610743823;
    property AppPath: WideString readonly dispid 1610743824;
    procedure Dispose; dispid 1610743825;
    property IsDisposed: WordBool readonly dispid 1610743826;
    procedure add_ApplicationClosed(const value: _EventHandler); dispid 1610743827;
    procedure remove_ApplicationClosed(const value: _EventHandler); dispid 1610743828;
    procedure add_ApplicationClosing(const value: IUnknown); dispid 1610743829;
    procedure remove_ApplicationClosing(const value: IUnknown); dispid 1610743830;
    procedure add_SketchClosed(const value: _EventHandler); dispid 1610743831;
    procedure remove_SketchClosed(const value: _EventHandler); dispid 1610743832;
    procedure add_SketchClosing(const value: IUnknown); dispid 1610743833;
    procedure remove_SketchClosing(const value: IUnknown); dispid 1610743834;
    procedure add_SketchLoaded(const value: _EventHandler); dispid 1610743835;
    procedure remove_SketchLoaded(const value: _EventHandler); dispid 1610743836;
    procedure add_SketchModified(const value: _EventHandler); dispid 1610743837;
    procedure remove_SketchModified(const value: _EventHandler); dispid 1610743838;
    procedure add_SketchSaved(const value: _EventHandler); dispid 1610743839;
    procedure remove_SketchSaved(const value: _EventHandler); dispid 1610743840;
    procedure add_PageChanged(const value: _EventHandler); dispid 1610743841;
    procedure remove_PageChanged(const value: _EventHandler); dispid 1610743842;
    procedure add_SymbolAdded(const value: IUnknown); dispid 1610743843;
    procedure remove_SymbolAdded(const value: IUnknown); dispid 1610743844;
    procedure add_SymbolRemoved(const value: IUnknown); dispid 1610743845;
    procedure remove_SymbolRemoved(const value: IUnknown); dispid 1610743846;
    procedure add_AreaAdded(const value: IUnknown); dispid 1610743847;
    procedure remove_AreaAdded(const value: IUnknown); dispid 1610743848;
    procedure add_AreaRemoved(const value: IUnknown); dispid 1610743849;
    procedure remove_AreaRemoved(const value: IUnknown); dispid 1610743850;
    procedure add_AreaChanged(const value: IUnknown); dispid 1610743851;
    procedure remove_AreaChanged(const value: IUnknown); dispid 1610743852;
    procedure add_GeoReferencePointsPlaced(const value: IUnknown); dispid 1610743853;
    procedure remove_GeoReferencePointsPlaced(const value: IUnknown); dispid 1610743854;
  end;

// *********************************************************************//
// Interface: IBreakdownShape
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B0143B97-96A9-4EBB-B222-1F9934904B06}
// *********************************************************************//
  IBreakdownShape = interface(IDispatch)
    ['{B0143B97-96A9-4EBB-B222-1F9934904B06}']
    function Get_name: WideString; safecall;
    function Get_Area: Double; safecall;
    function Get_Length: Double; safecall;
    function Get_Height: Double; safecall;
    function Get_CentralAngle: Double; safecall;
    property name: WideString read Get_name;
    property Area: Double read Get_Area;
    property Length: Double read Get_Length;
    property Height: Double read Get_Height;
    property CentralAngle: Double read Get_CentralAngle;
  end;

// *********************************************************************//
// DispIntf:  IBreakdownShapeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B0143B97-96A9-4EBB-B222-1F9934904B06}
// *********************************************************************//
  IBreakdownShapeDisp = dispinterface
    ['{B0143B97-96A9-4EBB-B222-1F9934904B06}']
    property name: WideString readonly dispid 1610743808;
    property Area: Double readonly dispid 1610743809;
    property Length: Double readonly dispid 1610743810;
    property Height: Double readonly dispid 1610743811;
    property CentralAngle: Double readonly dispid 1610743812;
  end;

// *********************************************************************//
// Interface: IAreaBreakdown
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B07596D6-9182-406D-B9EA-5D270B0EF4A4}
// *********************************************************************//
  IAreaBreakdown = interface(IDispatch)
    ['{B07596D6-9182-406D-B9EA-5D270B0EF4A4}']
    function Get_Item(index: Integer): IBreakdownShape; safecall;
    function Get_Count: Integer; safecall;
    function GetEnumerator: IEnumVARIANT; safecall;
    property Item[index: Integer]: IBreakdownShape read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IAreaBreakdownDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B07596D6-9182-406D-B9EA-5D270B0EF4A4}
// *********************************************************************//
  IAreaBreakdownDisp = dispinterface
    ['{B07596D6-9182-406D-B9EA-5D270B0EF4A4}']
    property Item[index: Integer]: IBreakdownShape readonly dispid 0; default;
    property Count: Integer readonly dispid 1610743809;
    function GetEnumerator: IEnumVARIANT; dispid -4;
  end;

// *********************************************************************//
// Interface: IArea
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0807E7C7-8766-4D20-B8C2-BDA53234F821}
// *********************************************************************//
  IArea = interface(IDispatch)
    ['{0807E7C7-8766-4D20-B8C2-BDA53234F821}']
    function Get_Code: WideString; safecall;
    function Get_name: WideString; safecall;
    function Get_Description: WideString; safecall;
    function Get_UniqueId: Integer; safecall;
    function Get_Multiplier: Double; safecall;
    function Get_Sign: Integer; safecall;
    function Get_NetArea: Double; safecall;
    function Get_Perimeter: Double; safecall;
    function Get_Tags: ITagCollection; safecall;
    function Get_WallArea: Double; safecall;
    function Get_AverageWallHeight: Double; safecall;
    procedure Delete; safecall;
    function Breakdown: IAreaBreakdown; safecall;
    property Code: WideString read Get_Code;
    property name: WideString read Get_name;
    property Description: WideString read Get_Description;
    property UniqueId: Integer read Get_UniqueId;
    property Multiplier: Double read Get_Multiplier;
    property Sign: Integer read Get_Sign;
    property NetArea: Double read Get_NetArea;
    property Perimeter: Double read Get_Perimeter;
    property Tags: ITagCollection read Get_Tags;
    property WallArea: Double read Get_WallArea;
    property AverageWallHeight: Double read Get_AverageWallHeight;
  end;

// *********************************************************************//
// DispIntf:  IAreaDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0807E7C7-8766-4D20-B8C2-BDA53234F821}
// *********************************************************************//
  IAreaDisp = dispinterface
    ['{0807E7C7-8766-4D20-B8C2-BDA53234F821}']
    property Code: WideString readonly dispid 1610743808;
    property name: WideString readonly dispid 1610743809;
    property Description: WideString readonly dispid 1610743810;
    property UniqueId: Integer readonly dispid 1610743811;
    property Multiplier: Double readonly dispid 1610743812;
    property Sign: Integer readonly dispid 1610743813;
    property NetArea: Double readonly dispid 1610743814;
    property Perimeter: Double readonly dispid 1610743815;
    property Tags: ITagCollection readonly dispid 1610743816;
    property WallArea: Double readonly dispid 1610743817;
    property AverageWallHeight: Double readonly dispid 1610743818;
    procedure Delete; dispid 1610743819;
    function Breakdown: IAreaBreakdown; dispid 1610743820;
  end;

// *********************************************************************//
// Interface: ITag
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7475C158-CD2B-44BE-92B9-342A2B0B2933}
// *********************************************************************//
  ITag = interface(IDispatch)
    ['{7475C158-CD2B-44BE-92B9-342A2B0B2933}']
    function Get_name: WideString; safecall;
    function Get_value: WideString; safecall;
    property name: WideString read Get_name;
    property value: WideString read Get_value;
  end;

// *********************************************************************//
// DispIntf:  ITagDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7475C158-CD2B-44BE-92B9-342A2B0B2933}
// *********************************************************************//
  ITagDisp = dispinterface
    ['{7475C158-CD2B-44BE-92B9-342A2B0B2933}']
    property name: WideString readonly dispid 1610743808;
    property value: WideString readonly dispid 0;
  end;

// *********************************************************************//
// Interface: ITagCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {292FEBD4-38E2-46D4-8F4C-FB698300C6E5}
// *********************************************************************//
  ITagCollection = interface(IDispatch)
    ['{292FEBD4-38E2-46D4-8F4C-FB698300C6E5}']
    function Get_Item(index: Integer): ITag; safecall;
    procedure Add(const name: WideString; const value: WideString); safecall;
    function Remove(const name: WideString): WordBool; safecall;
    function Contains(const name: WideString): WordBool; safecall;
    function IndexOf(const name: WideString): Integer; safecall;
    procedure Clear; safecall;
    function Get_Count: Integer; safecall;
    function GetEnumerator: IEnumVARIANT; safecall;
    property Item[index: Integer]: ITag read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ITagCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {292FEBD4-38E2-46D4-8F4C-FB698300C6E5}
// *********************************************************************//
  ITagCollectionDisp = dispinterface
    ['{292FEBD4-38E2-46D4-8F4C-FB698300C6E5}']
    property Item[index: Integer]: ITag readonly dispid 0; default;
    procedure Add(const name: WideString; const value: WideString); dispid 1610743809;
    function Remove(const name: WideString): WordBool; dispid 1610743810;
    function Contains(const name: WideString): WordBool; dispid 1610743811;
    function IndexOf(const name: WideString): Integer; dispid 1610743812;
    procedure Clear; dispid 1610743813;
    property Count: Integer readonly dispid 1610743814;
    function GetEnumerator: IEnumVARIANT; dispid -4;
  end;

// *********************************************************************//
// Interface: IGeoReferencePoint
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3FE5D998-8890-4D20-A845-B92A61E1A19E}
// *********************************************************************//
  IGeoReferencePoint = interface(IDispatch)
    ['{3FE5D998-8890-4D20-A845-B92A61E1A19E}']
    function Get_SketchX: Double; safecall;
    function Get_SketchY: Double; safecall;
    function Get_GeoCoordinates: WideString; safecall;
    procedure Set_GeoCoordinates(const pRetVal: WideString); safecall;
    property SketchX: Double read Get_SketchX;
    property SketchY: Double read Get_SketchY;
    property GeoCoordinates: WideString read Get_GeoCoordinates write Set_GeoCoordinates;
  end;

// *********************************************************************//
// DispIntf:  IGeoReferencePointDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3FE5D998-8890-4D20-A845-B92A61E1A19E}
// *********************************************************************//
  IGeoReferencePointDisp = dispinterface
    ['{3FE5D998-8890-4D20-A845-B92A61E1A19E}']
    property SketchX: Double readonly dispid 1610743808;
    property SketchY: Double readonly dispid 1610743809;
    property GeoCoordinates: WideString dispid 1610743810;
  end;

// *********************************************************************//
// Interface: IGeoReferencePointCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {53EAF615-A6CE-49A4-818F-B38D13FDB001}
// *********************************************************************//
  IGeoReferencePointCollection = interface(IDispatch)
    ['{53EAF615-A6CE-49A4-818F-B38D13FDB001}']
    function Get_Item(index: Integer): IGeoReferencePoint; safecall;
    function Get_Count: Integer; safecall;
    function Get_CoordinateSystem: WideString; safecall;
    procedure Set_CoordinateSystem(const pRetVal: WideString); safecall;
    property Item[index: Integer]: IGeoReferencePoint read Get_Item; default;
    property Count: Integer read Get_Count;
    property CoordinateSystem: WideString read Get_CoordinateSystem write Set_CoordinateSystem;
  end;

// *********************************************************************//
// DispIntf:  IGeoReferencePointCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {53EAF615-A6CE-49A4-818F-B38D13FDB001}
// *********************************************************************//
  IGeoReferencePointCollectionDisp = dispinterface
    ['{53EAF615-A6CE-49A4-818F-B38D13FDB001}']
    property Item[index: Integer]: IGeoReferencePoint readonly dispid 0; default;
    property Count: Integer readonly dispid 1610743809;
    property CoordinateSystem: WideString dispid 1610743810;
  end;

// *********************************************************************//
// Interface: IPage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {51361433-B9FC-4A4C-A7FD-050014487E47}
// *********************************************************************//
  IPage = interface(IDispatch)
    ['{51361433-B9FC-4A4C-A7FD-050014487E47}']
    function Get_Item(index: Integer): IArea; safecall;
    function Get_Count: Integer; safecall;
    function Get_GeoReferencePoints: IGeoReferencePointCollection; safecall;
    function ToPicture: IPictureDisp; safecall;
    property Item[index: Integer]: IArea read Get_Item; default;
    property Count: Integer read Get_Count;
    property GeoReferencePoints: IGeoReferencePointCollection read Get_GeoReferencePoints;
  end;

// *********************************************************************//
// DispIntf:  IPageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {51361433-B9FC-4A4C-A7FD-050014487E47}
// *********************************************************************//
  IPageDisp = dispinterface
    ['{51361433-B9FC-4A4C-A7FD-050014487E47}']
    property Item[index: Integer]: IArea readonly dispid 0; default;
    property Count: Integer readonly dispid 1610743809;
    property GeoReferencePoints: IGeoReferencePointCollection readonly dispid 1610743810;
    function ToPicture: IPictureDisp; dispid 1610743811;
  end;

// *********************************************************************//
// Interface: _SymbolEventArgs
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D547668F-9702-39E1-90BD-FF8B487C5756}
// *********************************************************************//
  _SymbolEventArgs = interface(IDispatch)
    ['{D547668F-9702-39E1-90BD-FF8B487C5756}']
    function Get_ToString: WideString; safecall;
    function Equals(obj: OleVariant): WordBool; safecall;
    function GetHashCode: Integer; safecall;
    function GetType: _Type; safecall;
    function Get_KeyCode: Integer; safecall;
    function Get_name: WideString; safecall;
    property ToString: WideString read Get_ToString;
    property KeyCode: Integer read Get_KeyCode;
    property name: WideString read Get_name;
  end;

// *********************************************************************//
// DispIntf:  _SymbolEventArgsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D547668F-9702-39E1-90BD-FF8B487C5756}
// *********************************************************************//
  _SymbolEventArgsDisp = dispinterface
    ['{D547668F-9702-39E1-90BD-FF8B487C5756}']
    property ToString: WideString readonly dispid 0;
    function Equals(obj: OleVariant): WordBool; dispid 1610743809;
    function GetHashCode: Integer; dispid 1610743810;
    function GetType: _Type; dispid 1610743811;
    property KeyCode: Integer readonly dispid 1610743812;
    property name: WideString readonly dispid 1610743813;
  end;

// *********************************************************************//
// Interface: _SketchItemEventArgs
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {697816F7-7CBC-3824-AC07-7BB83E8061D8}
// *********************************************************************//
  _SketchItemEventArgs = interface(IDispatch)
    ['{697816F7-7CBC-3824-AC07-7BB83E8061D8}']
    function Get_ToString: WideString; safecall;
    function Equals(obj: OleVariant): WordBool; safecall;
    function GetHashCode: Integer; safecall;
    function GetType: _Type; safecall;
    function Get_pageIndex: Integer; safecall;
    function Get_ItemIndex: Integer; safecall;
    function Get_ItemUniqueId: Integer; safecall;
    property ToString: WideString read Get_ToString;
    property pageIndex: Integer read Get_pageIndex;
    property ItemIndex: Integer read Get_ItemIndex;
    property ItemUniqueId: Integer read Get_ItemUniqueId;
  end;

// *********************************************************************//
// DispIntf:  _SketchItemEventArgsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {697816F7-7CBC-3824-AC07-7BB83E8061D8}
// *********************************************************************//
  _SketchItemEventArgsDisp = dispinterface
    ['{697816F7-7CBC-3824-AC07-7BB83E8061D8}']
    property ToString: WideString readonly dispid 0;
    function Equals(obj: OleVariant): WordBool; dispid 1610743809;
    function GetHashCode: Integer; dispid 1610743810;
    function GetType: _Type; dispid 1610743811;
    property pageIndex: Integer readonly dispid 1610743812;
    property ItemIndex: Integer readonly dispid 1610743813;
    property ItemUniqueId: Integer readonly dispid 1610743814;
  end;

// *********************************************************************//
// Interface: ISketch
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DADD945B-1C2A-416E-80CB-0B05444E13A4}
// *********************************************************************//
  ISketch = interface(IDispatch)
    ['{DADD945B-1C2A-416E-80CB-0B05444E13A4}']
    function Get_Item(index: Integer): IPage; safecall;
    function Get_Count: Integer; safecall;
    function Get_pageIndex: Integer; safecall;
    procedure Set_pageIndex(pRetVal: Integer); safecall;
    function Get_name: WideString; safecall;
    function Get_Subject: ISubject; safecall;
    procedure Close; safecall;
    procedure Save; safecall;
    procedure SaveAs(const path: WideString); safecall;
    function ZoomToItem(KeyCode: Integer): WordBool; safecall;
    property Item[index: Integer]: IPage read Get_Item; default;
    property Count: Integer read Get_Count;
    property pageIndex: Integer read Get_pageIndex write Set_pageIndex;
    property name: WideString read Get_name;
    property Subject: ISubject read Get_Subject;
  end;

// *********************************************************************//
// DispIntf:  ISketchDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DADD945B-1C2A-416E-80CB-0B05444E13A4}
// *********************************************************************//
  ISketchDisp = dispinterface
    ['{DADD945B-1C2A-416E-80CB-0B05444E13A4}']
    property Item[index: Integer]: IPage readonly dispid 0; default;
    property Count: Integer readonly dispid 1610743809;
    property pageIndex: Integer dispid 1610743810;
    property name: WideString readonly dispid 1610743812;
    property Subject: ISubject readonly dispid 1610743813;
    procedure Close; dispid 1610743814;
    procedure Save; dispid 1610743815;
    procedure SaveAs(const path: WideString); dispid 1610743816;
    function ZoomToItem(KeyCode: Integer): WordBool; dispid 1610743817;
  end;

// *********************************************************************//
// DispIntf:  ISketchClientEvents
// Flags:     (4096) Dispatchable
// GUID:      {22C11A2D-8057-4674-8E76-19C0C2720033}
// *********************************************************************//
  ISketchClientEvents = dispinterface
    ['{22C11A2D-8057-4674-8E76-19C0C2720033}']
    procedure ApplicationClosed(sender: OleVariant; const e: _EventArgs); dispid 1;
    procedure ApplicationClosing(sender: OleVariant; const e: IUnknown); dispid 2;
    procedure SketchClosed(sender: OleVariant; const e: _EventArgs); dispid 3;
    procedure SketchClosing(sender: OleVariant; const e: IUnknown); dispid 4;
    procedure SketchLoaded(sender: OleVariant; const e: _EventArgs); dispid 5;
    procedure SketchModified(sender: OleVariant; const e: _EventArgs); dispid 6;
    procedure SketchSaved(sender: OleVariant; const e: _EventArgs); dispid 7;
    procedure PageChanged(sender: OleVariant; const e: _EventArgs); dispid 8;
    procedure SymbolAdded(sender: OleVariant; const e: _SymbolEventArgs); dispid 9;
    procedure SymbolRemoved(sender: OleVariant; const e: _SymbolEventArgs); dispid 10;
    procedure AreaAdded(sender: OleVariant; const e: _SketchItemEventArgs); dispid 11;
    procedure AreaChanged(sender: OleVariant; const e: _SketchItemEventArgs); dispid 12;
    procedure AreaRemoved(sender: OleVariant; const e: _SketchItemEventArgs); dispid 13;
    procedure GeoReferencePointsPlaced(sender: OleVariant; const e: IUnknown); dispid 14;
  end;

// *********************************************************************//
// Interface: ISubject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B17C1D0B-D1A5-46A3-91FA-91641D3E4AD5}
// *********************************************************************//
  ISubject = interface(IDispatch)
    ['{B17C1D0B-D1A5-46A3-91FA-91641D3E4AD5}']
    function Get_Appraiser: WideString; safecall;
    procedure Set_Appraiser(const pRetVal: WideString); safecall;
    function Get_AppraiserAddress: WideString; safecall;
    procedure Set_AppraiserAddress(const pRetVal: WideString); safecall;
    function Get_Borrower: WideString; safecall;
    procedure Set_Borrower(const pRetVal: WideString); safecall;
    function Get_CaseNumber: WideString; safecall;
    procedure Set_CaseNumber(const pRetVal: WideString); safecall;
    function Get_City: WideString; safecall;
    procedure Set_City(const pRetVal: WideString); safecall;
    function Get_County: WideString; safecall;
    procedure Set_County(const pRetVal: WideString); safecall;
    function Get_FileNumber: WideString; safecall;
    procedure Set_FileNumber(const pRetVal: WideString); safecall;
    function Get_LenderClient: WideString; safecall;
    procedure Set_LenderClient(const pRetVal: WideString); safecall;
    function Get_LenderClientAddress: WideString; safecall;
    procedure Set_LenderClientAddress(const pRetVal: WideString); safecall;
    function Get_PropertyAddress: WideString; safecall;
    procedure Set_PropertyAddress(const pRetVal: WideString); safecall;
    function Get_State: WideString; safecall;
    procedure Set_State(const pRetVal: WideString); safecall;
    function Get_ZipCode: WideString; safecall;
    procedure Set_ZipCode(const pRetVal: WideString); safecall;
    function Get_Tags: ITagCollection; safecall;
    property Appraiser: WideString read Get_Appraiser write Set_Appraiser;
    property AppraiserAddress: WideString read Get_AppraiserAddress write Set_AppraiserAddress;
    property Borrower: WideString read Get_Borrower write Set_Borrower;
    property CaseNumber: WideString read Get_CaseNumber write Set_CaseNumber;
    property City: WideString read Get_City write Set_City;
    property County: WideString read Get_County write Set_County;
    property FileNumber: WideString read Get_FileNumber write Set_FileNumber;
    property LenderClient: WideString read Get_LenderClient write Set_LenderClient;
    property LenderClientAddress: WideString read Get_LenderClientAddress write Set_LenderClientAddress;
    property PropertyAddress: WideString read Get_PropertyAddress write Set_PropertyAddress;
    property State: WideString read Get_State write Set_State;
    property ZipCode: WideString read Get_ZipCode write Set_ZipCode;
    property Tags: ITagCollection read Get_Tags;
  end;

// *********************************************************************//
// DispIntf:  ISubjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B17C1D0B-D1A5-46A3-91FA-91641D3E4AD5}
// *********************************************************************//
  ISubjectDisp = dispinterface
    ['{B17C1D0B-D1A5-46A3-91FA-91641D3E4AD5}']
    property Appraiser: WideString dispid 1610743808;
    property AppraiserAddress: WideString dispid 1610743810;
    property Borrower: WideString dispid 1610743812;
    property CaseNumber: WideString dispid 1610743814;
    property City: WideString dispid 1610743816;
    property County: WideString dispid 1610743818;
    property FileNumber: WideString dispid 1610743820;
    property LenderClient: WideString dispid 1610743822;
    property LenderClientAddress: WideString dispid 1610743824;
    property PropertyAddress: WideString dispid 1610743826;
    property State: WideString dispid 1610743828;
    property ZipCode: WideString dispid 1610743830;
    property Tags: ITagCollection readonly dispid 1610743832;
  end;

// *********************************************************************//
// Interface: _SketchClient
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {25F90085-8250-3B13-B969-097E85991906}
// *********************************************************************//
  _SketchClient = interface(IDispatch)
    ['{25F90085-8250-3B13-B969-097E85991906}']
  end;

// *********************************************************************//
// DispIntf:  _SketchClientDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {25F90085-8250-3B13-B969-097E85991906}
// *********************************************************************//
  _SketchClientDisp = dispinterface
    ['{25F90085-8250-3B13-B969-097E85991906}']
  end;

// *********************************************************************//
// The Class CoBreakdownShape provides a Create and CreateRemote method to          
// create instances of the default interface IBreakdownShape exposed by              
// the CoClass BreakdownShape. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBreakdownShape = class
    class function Create: IBreakdownShape;
    class function CreateRemote(const MachineName: string): IBreakdownShape;
  end;

// *********************************************************************//
// The Class CoAreaBreakDown provides a Create and CreateRemote method to          
// create instances of the default interface IAreaBreakdown exposed by              
// the CoClass AreaBreakDown. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAreaBreakDown = class
    class function Create: IAreaBreakdown;
    class function CreateRemote(const MachineName: string): IAreaBreakdown;
  end;

// *********************************************************************//
// The Class CoArea provides a Create and CreateRemote method to          
// create instances of the default interface IArea exposed by              
// the CoClass Area. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoArea = class
    class function Create: IArea;
    class function CreateRemote(const MachineName: string): IArea;
  end;

// *********************************************************************//
// The Class CoProxyTag provides a Create and CreateRemote method to          
// create instances of the default interface ITag exposed by              
// the CoClass ProxyTag. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProxyTag = class
    class function Create: ITag;
    class function CreateRemote(const MachineName: string): ITag;
  end;

// *********************************************************************//
// The Class CoTagCollection provides a Create and CreateRemote method to          
// create instances of the default interface ITagCollection exposed by              
// the CoClass TagCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTagCollection = class
    class function Create: ITagCollection;
    class function CreateRemote(const MachineName: string): ITagCollection;
  end;

// *********************************************************************//
// The Class CoGeoReferencePoint provides a Create and CreateRemote method to          
// create instances of the default interface IGeoReferencePoint exposed by              
// the CoClass GeoReferencePoint. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGeoReferencePoint = class
    class function Create: IGeoReferencePoint;
    class function CreateRemote(const MachineName: string): IGeoReferencePoint;
  end;

// *********************************************************************//
// The Class CoGeoReferencePointCollection provides a Create and CreateRemote method to          
// create instances of the default interface IGeoReferencePointCollection exposed by              
// the CoClass GeoReferencePointCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGeoReferencePointCollection = class
    class function Create: IGeoReferencePointCollection;
    class function CreateRemote(const MachineName: string): IGeoReferencePointCollection;
  end;

// *********************************************************************//
// The Class CoPage provides a Create and CreateRemote method to          
// create instances of the default interface IPage exposed by              
// the CoClass Page. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPage = class
    class function Create: IPage;
    class function CreateRemote(const MachineName: string): IPage;
  end;

// *********************************************************************//
// The Class CoSketch provides a Create and CreateRemote method to          
// create instances of the default interface ISketch exposed by              
// the CoClass Sketch. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSketch = class
    class function Create: ISketch;
    class function CreateRemote(const MachineName: string): ISketch;
  end;

// *********************************************************************//
// The Class CoSubject provides a Create and CreateRemote method to          
// create instances of the default interface ISubject exposed by              
// the CoClass Subject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubject = class
    class function Create: ISubject;
    class function CreateRemote(const MachineName: string): ISubject;
  end;

// *********************************************************************//
// The Class CoApexSketch provides a Create and CreateRemote method to          
// create instances of the default interface ISketchClient exposed by              
// the CoClass ApexSketch. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApexSketch = class
    class function Create: ISketchClient;
    class function CreateRemote(const MachineName: string): ISketchClient;
  end;

  TApexSketchApplicationClosed = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchApplicationClosing = procedure(ASender: TObject; sender: OleVariant; const e: IUnknown) of object;
  TApexSketchSketchClosed = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchSketchClosing = procedure(ASender: TObject; sender: OleVariant; const e: IUnknown) of object;
  TApexSketchSketchLoaded = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchSketchModified = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchSketchSaved = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchPageChanged = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TApexSketchSymbolAdded = procedure(ASender: TObject; sender: OleVariant; const e: _SymbolEventArgs) of object;
  TApexSketchSymbolRemoved = procedure(ASender: TObject; sender: OleVariant; 
                                                         const e: _SymbolEventArgs) of object;
  TApexSketchAreaAdded = procedure(ASender: TObject; sender: OleVariant; 
                                                     const e: _SketchItemEventArgs) of object;
  TApexSketchAreaChanged = procedure(ASender: TObject; sender: OleVariant; 
                                                       const e: _SketchItemEventArgs) of object;
  TApexSketchAreaRemoved = procedure(ASender: TObject; sender: OleVariant; 
                                                       const e: _SketchItemEventArgs) of object;
  TApexSketchGeoReferencePointsPlaced = procedure(ASender: TObject; sender: OleVariant; 
                                                                    const e: IUnknown) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TApexSketch
// Help String      : 
// Default Interface: ISketchClient
// Def. Intf. DISP? : No
// Event   Interface: ISketchClientEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TApexSketchProperties= class;
{$ENDIF}
  TApexSketch = class(TOleServer)
  private
    FOnApplicationClosed: TApexSketchApplicationClosed;
    FOnApplicationClosing: TApexSketchApplicationClosing;
    FOnSketchClosed: TApexSketchSketchClosed;
    FOnSketchClosing: TApexSketchSketchClosing;
    FOnSketchLoaded: TApexSketchSketchLoaded;
    FOnSketchModified: TApexSketchSketchModified;
    FOnSketchSaved: TApexSketchSketchSaved;
    FOnPageChanged: TApexSketchPageChanged;
    FOnSymbolAdded: TApexSketchSymbolAdded;
    FOnSymbolRemoved: TApexSketchSymbolRemoved;
    FOnAreaAdded: TApexSketchAreaAdded;
    FOnAreaChanged: TApexSketchAreaChanged;
    FOnAreaRemoved: TApexSketchAreaRemoved;
    FOnGeoReferencePointsPlaced: TApexSketchGeoReferencePointsPlaced;
    FIntf:        ISketchClient;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TApexSketchProperties;
    function      GetServerProperties: TApexSketchProperties;
{$ENDIF}
    function      GetDefaultInterface: ISketchClient;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Sketch: ISketch;
    function Get_AreaCodeTableUrl: WideString;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString);
    function Get_IsAppRunning: WordBool;
    function Get_AppPath: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISketchClient);
    procedure Disconnect; override;
    procedure Exit;
    function New: ISketch;
    function NewAs(const path: WideString): ISketch;
    function Open(const path: WideString): ISketch;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch;
    function OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch;
    function SaveAsBase64String: WideString;
    procedure ExportPageImages(const path: WideString; const options: WideString);
    property DefaultInterface: ISketchClient read GetDefaultInterface;
    property Sketch: ISketch read Get_Sketch;
    property IsAppRunning: WordBool read Get_IsAppRunning;
    property AppPath: WideString read Get_AppPath;
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TApexSketchProperties read GetServerProperties;
{$ENDIF}
    property OnApplicationClosed: TApexSketchApplicationClosed read FOnApplicationClosed write FOnApplicationClosed;
    property OnApplicationClosing: TApexSketchApplicationClosing read FOnApplicationClosing write FOnApplicationClosing;
    property OnSketchClosed: TApexSketchSketchClosed read FOnSketchClosed write FOnSketchClosed;
    property OnSketchClosing: TApexSketchSketchClosing read FOnSketchClosing write FOnSketchClosing;
    property OnSketchLoaded: TApexSketchSketchLoaded read FOnSketchLoaded write FOnSketchLoaded;
    property OnSketchModified: TApexSketchSketchModified read FOnSketchModified write FOnSketchModified;
    property OnSketchSaved: TApexSketchSketchSaved read FOnSketchSaved write FOnSketchSaved;
    property OnPageChanged: TApexSketchPageChanged read FOnPageChanged write FOnPageChanged;
    property OnSymbolAdded: TApexSketchSymbolAdded read FOnSymbolAdded write FOnSymbolAdded;
    property OnSymbolRemoved: TApexSketchSymbolRemoved read FOnSymbolRemoved write FOnSymbolRemoved;
    property OnAreaAdded: TApexSketchAreaAdded read FOnAreaAdded write FOnAreaAdded;
    property OnAreaChanged: TApexSketchAreaChanged read FOnAreaChanged write FOnAreaChanged;
    property OnAreaRemoved: TApexSketchAreaRemoved read FOnAreaRemoved write FOnAreaRemoved;
    property OnGeoReferencePointsPlaced: TApexSketchGeoReferencePointsPlaced read FOnGeoReferencePointsPlaced write FOnGeoReferencePointsPlaced;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TApexSketch
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TApexSketchProperties = class(TPersistent)
  private
    FServer:    TApexSketch;
    function    GetDefaultInterface: ISketchClient;
    constructor Create(AServer: TApexSketch);
  protected
    function Get_Sketch: ISketch;
    function Get_AreaCodeTableUrl: WideString;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString);
    function Get_IsAppRunning: WordBool;
    function Get_AppPath: WideString;
  public
    property DefaultInterface: ISketchClient read GetDefaultInterface;
  published
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSymbolEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _SymbolEventArgs exposed by              
// the CoClass SymbolEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSymbolEventArgs = class
    class function Create: _SymbolEventArgs;
    class function CreateRemote(const MachineName: string): _SymbolEventArgs;
  end;

// *********************************************************************//
// The Class CoSketchItemEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _SketchItemEventArgs exposed by              
// the CoClass SketchItemEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSketchItemEventArgs = class
    class function Create: _SketchItemEventArgs;
    class function CreateRemote(const MachineName: string): _SketchItemEventArgs;
  end;

// *********************************************************************//
// The Class CoSketchClient provides a Create and CreateRemote method to          
// create instances of the default interface ISketchClient exposed by              
// the CoClass SketchClient. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSketchClient = class
    class function Create: ISketchClient;
    class function CreateRemote(const MachineName: string): ISketchClient;
  end;

  TSketchClientApplicationClosed = procedure(ASender: TObject; sender: OleVariant; 
                                                               const e: _EventArgs) of object;
  TSketchClientApplicationClosing = procedure(ASender: TObject; sender: OleVariant; 
                                                                const e: IUnknown) of object;
  TSketchClientSketchClosed = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TSketchClientSketchClosing = procedure(ASender: TObject; sender: OleVariant; const e: IUnknown) of object;
  TSketchClientSketchLoaded = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TSketchClientSketchModified = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TSketchClientSketchSaved = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TSketchClientPageChanged = procedure(ASender: TObject; sender: OleVariant; const e: _EventArgs) of object;
  TSketchClientSymbolAdded = procedure(ASender: TObject; sender: OleVariant; 
                                                         const e: _SymbolEventArgs) of object;
  TSketchClientSymbolRemoved = procedure(ASender: TObject; sender: OleVariant; 
                                                           const e: _SymbolEventArgs) of object;
  TSketchClientAreaAdded = procedure(ASender: TObject; sender: OleVariant; 
                                                       const e: _SketchItemEventArgs) of object;
  TSketchClientAreaChanged = procedure(ASender: TObject; sender: OleVariant; 
                                                         const e: _SketchItemEventArgs) of object;
  TSketchClientAreaRemoved = procedure(ASender: TObject; sender: OleVariant; 
                                                         const e: _SketchItemEventArgs) of object;
  TSketchClientGeoReferencePointsPlaced = procedure(ASender: TObject; sender: OleVariant; 
                                                                      const e: IUnknown) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSketchClient
// Help String      : 
// Default Interface: ISketchClient
// Def. Intf. DISP? : No
// Event   Interface: ISketchClientEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSketchClientProperties= class;
{$ENDIF}
  TSketchClient = class(TOleServer)
  private
    FOnApplicationClosed: TSketchClientApplicationClosed;
    FOnApplicationClosing: TSketchClientApplicationClosing;
    FOnSketchClosed: TSketchClientSketchClosed;
    FOnSketchClosing: TSketchClientSketchClosing;
    FOnSketchLoaded: TSketchClientSketchLoaded;
    FOnSketchModified: TSketchClientSketchModified;
    FOnSketchSaved: TSketchClientSketchSaved;
    FOnPageChanged: TSketchClientPageChanged;
    FOnSymbolAdded: TSketchClientSymbolAdded;
    FOnSymbolRemoved: TSketchClientSymbolRemoved;
    FOnAreaAdded: TSketchClientAreaAdded;
    FOnAreaChanged: TSketchClientAreaChanged;
    FOnAreaRemoved: TSketchClientAreaRemoved;
    FOnGeoReferencePointsPlaced: TSketchClientGeoReferencePointsPlaced;
    FIntf:        ISketchClient;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSketchClientProperties;
    function      GetServerProperties: TSketchClientProperties;
{$ENDIF}
    function      GetDefaultInterface: ISketchClient;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Sketch: ISketch;
    function Get_AreaCodeTableUrl: WideString;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString);
    function Get_IsAppRunning: WordBool;
    function Get_AppPath: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISketchClient);
    procedure Disconnect; override;
    procedure Exit;
    function New: ISketch;
    function NewAs(const path: WideString): ISketch;
    function Open(const path: WideString): ISketch;
    function OpenToPage(const path: WideString; pageIndex: Integer): ISketch;
    function OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch;
    function SaveAsBase64String: WideString;
    procedure ExportPageImages(const path: WideString; const options: WideString);
    property DefaultInterface: ISketchClient read GetDefaultInterface;
    property Sketch: ISketch read Get_Sketch;
    property IsAppRunning: WordBool read Get_IsAppRunning;
    property AppPath: WideString read Get_AppPath;
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSketchClientProperties read GetServerProperties;
{$ENDIF}
    property OnApplicationClosed: TSketchClientApplicationClosed read FOnApplicationClosed write FOnApplicationClosed;
    property OnApplicationClosing: TSketchClientApplicationClosing read FOnApplicationClosing write FOnApplicationClosing;
    property OnSketchClosed: TSketchClientSketchClosed read FOnSketchClosed write FOnSketchClosed;
    property OnSketchClosing: TSketchClientSketchClosing read FOnSketchClosing write FOnSketchClosing;
    property OnSketchLoaded: TSketchClientSketchLoaded read FOnSketchLoaded write FOnSketchLoaded;
    property OnSketchModified: TSketchClientSketchModified read FOnSketchModified write FOnSketchModified;
    property OnSketchSaved: TSketchClientSketchSaved read FOnSketchSaved write FOnSketchSaved;
    property OnPageChanged: TSketchClientPageChanged read FOnPageChanged write FOnPageChanged;
    property OnSymbolAdded: TSketchClientSymbolAdded read FOnSymbolAdded write FOnSymbolAdded;
    property OnSymbolRemoved: TSketchClientSymbolRemoved read FOnSymbolRemoved write FOnSymbolRemoved;
    property OnAreaAdded: TSketchClientAreaAdded read FOnAreaAdded write FOnAreaAdded;
    property OnAreaChanged: TSketchClientAreaChanged read FOnAreaChanged write FOnAreaChanged;
    property OnAreaRemoved: TSketchClientAreaRemoved read FOnAreaRemoved write FOnAreaRemoved;
    property OnGeoReferencePointsPlaced: TSketchClientGeoReferencePointsPlaced read FOnGeoReferencePointsPlaced write FOnGeoReferencePointsPlaced;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSketchClient
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSketchClientProperties = class(TPersistent)
  private
    FServer:    TSketchClient;
    function    GetDefaultInterface: ISketchClient;
    constructor Create(AServer: TSketchClient);
  protected
    function Get_Sketch: ISketch;
    function Get_AreaCodeTableUrl: WideString;
    procedure Set_AreaCodeTableUrl(const pRetVal: WideString);
    function Get_IsAppRunning: WordBool;
    function Get_AppPath: WideString;
  public
    property DefaultInterface: ISketchClient read GetDefaultInterface;
  published
    property AreaCodeTableUrl: WideString read Get_AreaCodeTableUrl write Set_AreaCodeTableUrl;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoBreakdownShape.Create: IBreakdownShape;
begin
  Result := CreateComObject(CLASS_BreakdownShape) as IBreakdownShape;
end;

class function CoBreakdownShape.CreateRemote(const MachineName: string): IBreakdownShape;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BreakdownShape) as IBreakdownShape;
end;

class function CoAreaBreakDown.Create: IAreaBreakdown;
begin
  Result := CreateComObject(CLASS_AreaBreakDown) as IAreaBreakdown;
end;

class function CoAreaBreakDown.CreateRemote(const MachineName: string): IAreaBreakdown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AreaBreakDown) as IAreaBreakdown;
end;

class function CoArea.Create: IArea;
begin
  Result := CreateComObject(CLASS_Area) as IArea;
end;

class function CoArea.CreateRemote(const MachineName: string): IArea;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Area) as IArea;
end;

class function CoProxyTag.Create: ITag;
begin
  Result := CreateComObject(CLASS_ProxyTag) as ITag;
end;

class function CoProxyTag.CreateRemote(const MachineName: string): ITag;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProxyTag) as ITag;
end;

class function CoTagCollection.Create: ITagCollection;
begin
  Result := CreateComObject(CLASS_TagCollection) as ITagCollection;
end;

class function CoTagCollection.CreateRemote(const MachineName: string): ITagCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TagCollection) as ITagCollection;
end;

class function CoGeoReferencePoint.Create: IGeoReferencePoint;
begin
  Result := CreateComObject(CLASS_GeoReferencePoint) as IGeoReferencePoint;
end;

class function CoGeoReferencePoint.CreateRemote(const MachineName: string): IGeoReferencePoint;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GeoReferencePoint) as IGeoReferencePoint;
end;

class function CoGeoReferencePointCollection.Create: IGeoReferencePointCollection;
begin
  Result := CreateComObject(CLASS_GeoReferencePointCollection) as IGeoReferencePointCollection;
end;

class function CoGeoReferencePointCollection.CreateRemote(const MachineName: string): IGeoReferencePointCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GeoReferencePointCollection) as IGeoReferencePointCollection;
end;

class function CoPage.Create: IPage;
begin
  Result := CreateComObject(CLASS_Page) as IPage;
end;

class function CoPage.CreateRemote(const MachineName: string): IPage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Page) as IPage;
end;

class function CoSketch.Create: ISketch;
begin
  Result := CreateComObject(CLASS_Sketch) as ISketch;
end;

class function CoSketch.CreateRemote(const MachineName: string): ISketch;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Sketch) as ISketch;
end;

class function CoSubject.Create: ISubject;
begin
  Result := CreateComObject(CLASS_Subject) as ISubject;
end;

class function CoSubject.CreateRemote(const MachineName: string): ISubject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Subject) as ISubject;
end;

class function CoApexSketch.Create: ISketchClient;
begin
  Result := CreateComObject(CLASS_ApexSketch) as ISketchClient;
end;

class function CoApexSketch.CreateRemote(const MachineName: string): ISketchClient;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ApexSketch) as ISketchClient;
end;

procedure TApexSketch.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8665AC21-01AE-4156-90F0-EA54DF1CB6E2}';
    IntfIID:   '{7EE40959-4D4C-41B4-A807-4DE9E0848A80}';
    EventIID:  '{22C11A2D-8057-4674-8E76-19C0C2720033}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TApexSketch.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ISketchClient;
  end;
end;

procedure TApexSketch.ConnectTo(svrIntf: ISketchClient);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TApexSketch.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TApexSketch.GetDefaultInterface: ISketchClient;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TApexSketch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TApexSketchProperties.Create(Self);
{$ENDIF}
end;

destructor TApexSketch.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TApexSketch.GetServerProperties: TApexSketchProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TApexSketch.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnApplicationClosed) then
         FOnApplicationClosed(Self,
                              Params[0] {OleVariant},
                              IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    2: if Assigned(FOnApplicationClosing) then
         FOnApplicationClosing(Self,
                               Params[0] {OleVariant},
                               Params[1] {const IUnknown});
    3: if Assigned(FOnSketchClosed) then
         FOnSketchClosed(Self,
                         Params[0] {OleVariant},
                         IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    4: if Assigned(FOnSketchClosing) then
         FOnSketchClosing(Self,
                          Params[0] {OleVariant},
                          Params[1] {const IUnknown});
    5: if Assigned(FOnSketchLoaded) then
         FOnSketchLoaded(Self,
                         Params[0] {OleVariant},
                         IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    6: if Assigned(FOnSketchModified) then
         FOnSketchModified(Self,
                           Params[0] {OleVariant},
                           IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    7: if Assigned(FOnSketchSaved) then
         FOnSketchSaved(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    8: if Assigned(FOnPageChanged) then
         FOnPageChanged(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    9: if Assigned(FOnSymbolAdded) then
         FOnSymbolAdded(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SymbolEventArgs {const _SymbolEventArgs});
    10: if Assigned(FOnSymbolRemoved) then
         FOnSymbolRemoved(Self,
                          Params[0] {OleVariant},
                          IUnknown(TVarData(Params[1]).VPointer) as _SymbolEventArgs {const _SymbolEventArgs});
    11: if Assigned(FOnAreaAdded) then
         FOnAreaAdded(Self,
                      Params[0] {OleVariant},
                      IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    12: if Assigned(FOnAreaChanged) then
         FOnAreaChanged(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    13: if Assigned(FOnAreaRemoved) then
         FOnAreaRemoved(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    14: if Assigned(FOnGeoReferencePointsPlaced) then
         FOnGeoReferencePointsPlaced(Self,
                                     Params[0] {OleVariant},
                                     Params[1] {const IUnknown});
  end; {case DispID}
end;

function TApexSketch.Get_Sketch: ISketch;
begin
    Result := DefaultInterface.Sketch;
end;

function TApexSketch.Get_AreaCodeTableUrl: WideString;
begin
    Result := DefaultInterface.AreaCodeTableUrl;
end;

procedure TApexSketch.Set_AreaCodeTableUrl(const pRetVal: WideString);
  { Warning: The property AreaCodeTableUrl has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AreaCodeTableUrl := pRetVal;
end;

function TApexSketch.Get_IsAppRunning: WordBool;
begin
    Result := DefaultInterface.IsAppRunning;
end;

function TApexSketch.Get_AppPath: WideString;
begin
    Result := DefaultInterface.AppPath;
end;

procedure TApexSketch.Exit;
begin
  DefaultInterface.Exit;
end;

function TApexSketch.New: ISketch;
begin
  Result := DefaultInterface.New;
end;

function TApexSketch.NewAs(const path: WideString): ISketch;
begin
  Result := DefaultInterface.NewAs(path);
end;

function TApexSketch.Open(const path: WideString): ISketch;
begin
  Result := DefaultInterface.Open(path);
end;

function TApexSketch.OpenToPage(const path: WideString; pageIndex: Integer): ISketch;
begin
  Result := DefaultInterface.OpenToPage(path, pageIndex);
end;

function TApexSketch.OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch;
begin
  Result := DefaultInterface.OpenFromBase64String(base64Sketch, pageIndex);
end;

function TApexSketch.SaveAsBase64String: WideString;
begin
  Result := DefaultInterface.SaveAsBase64String;
end;

procedure TApexSketch.ExportPageImages(const path: WideString; const options: WideString);
begin
  DefaultInterface.ExportPageImages(path, options);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TApexSketchProperties.Create(AServer: TApexSketch);
begin
  inherited Create;
  FServer := AServer;
end;

function TApexSketchProperties.GetDefaultInterface: ISketchClient;
begin
  Result := FServer.DefaultInterface;
end;

function TApexSketchProperties.Get_Sketch: ISketch;
begin
    Result := DefaultInterface.Sketch;
end;

function TApexSketchProperties.Get_AreaCodeTableUrl: WideString;
begin
    Result := DefaultInterface.AreaCodeTableUrl;
end;

procedure TApexSketchProperties.Set_AreaCodeTableUrl(const pRetVal: WideString);
  { Warning: The property AreaCodeTableUrl has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AreaCodeTableUrl := pRetVal;
end;

function TApexSketchProperties.Get_IsAppRunning: WordBool;
begin
    Result := DefaultInterface.IsAppRunning;
end;

function TApexSketchProperties.Get_AppPath: WideString;
begin
    Result := DefaultInterface.AppPath;
end;

{$ENDIF}

class function CoSymbolEventArgs.Create: _SymbolEventArgs;
begin
  Result := CreateComObject(CLASS_SymbolEventArgs) as _SymbolEventArgs;
end;

class function CoSymbolEventArgs.CreateRemote(const MachineName: string): _SymbolEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SymbolEventArgs) as _SymbolEventArgs;
end;

class function CoSketchItemEventArgs.Create: _SketchItemEventArgs;
begin
  Result := CreateComObject(CLASS_SketchItemEventArgs) as _SketchItemEventArgs;
end;

class function CoSketchItemEventArgs.CreateRemote(const MachineName: string): _SketchItemEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SketchItemEventArgs) as _SketchItemEventArgs;
end;

class function CoSketchClient.Create: ISketchClient;
begin
  Result := CreateComObject(CLASS_SketchClient) as ISketchClient;
end;

class function CoSketchClient.CreateRemote(const MachineName: string): ISketchClient;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SketchClient) as ISketchClient;
end;

procedure TSketchClient.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8336A4AA-E39C-487E-A34C-BC451F6E4775}';
    IntfIID:   '{7EE40959-4D4C-41B4-A807-4DE9E0848A80}';
    EventIID:  '{22C11A2D-8057-4674-8E76-19C0C2720033}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSketchClient.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ISketchClient;
  end;
end;

procedure TSketchClient.ConnectTo(svrIntf: ISketchClient);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TSketchClient.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TSketchClient.GetDefaultInterface: ISketchClient;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSketchClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSketchClientProperties.Create(Self);
{$ENDIF}
end;

destructor TSketchClient.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSketchClient.GetServerProperties: TSketchClientProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TSketchClient.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnApplicationClosed) then
         FOnApplicationClosed(Self,
                              Params[0] {OleVariant},
                              IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    2: if Assigned(FOnApplicationClosing) then
         FOnApplicationClosing(Self,
                               Params[0] {OleVariant},
                               Params[1] {const IUnknown});
    3: if Assigned(FOnSketchClosed) then
         FOnSketchClosed(Self,
                         Params[0] {OleVariant},
                         IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    4: if Assigned(FOnSketchClosing) then
         FOnSketchClosing(Self,
                          Params[0] {OleVariant},
                          Params[1] {const IUnknown});
    5: if Assigned(FOnSketchLoaded) then
         FOnSketchLoaded(Self,
                         Params[0] {OleVariant},
                         IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    6: if Assigned(FOnSketchModified) then
         FOnSketchModified(Self,
                           Params[0] {OleVariant},
                           IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    7: if Assigned(FOnSketchSaved) then
         FOnSketchSaved(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    8: if Assigned(FOnPageChanged) then
         FOnPageChanged(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _EventArgs {const _EventArgs});
    9: if Assigned(FOnSymbolAdded) then
         FOnSymbolAdded(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SymbolEventArgs {const _SymbolEventArgs});
    10: if Assigned(FOnSymbolRemoved) then
         FOnSymbolRemoved(Self,
                          Params[0] {OleVariant},
                          IUnknown(TVarData(Params[1]).VPointer) as _SymbolEventArgs {const _SymbolEventArgs});
    11: if Assigned(FOnAreaAdded) then
         FOnAreaAdded(Self,
                      Params[0] {OleVariant},
                      IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    12: if Assigned(FOnAreaChanged) then
         FOnAreaChanged(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    13: if Assigned(FOnAreaRemoved) then
         FOnAreaRemoved(Self,
                        Params[0] {OleVariant},
                        IUnknown(TVarData(Params[1]).VPointer) as _SketchItemEventArgs {const _SketchItemEventArgs});
    14: if Assigned(FOnGeoReferencePointsPlaced) then
         FOnGeoReferencePointsPlaced(Self,
                                     Params[0] {OleVariant},
                                     Params[1] {const IUnknown});
  end; {case DispID}
end;

function TSketchClient.Get_Sketch: ISketch;
begin
    Result := DefaultInterface.Sketch;
end;

function TSketchClient.Get_AreaCodeTableUrl: WideString;
begin
    Result := DefaultInterface.AreaCodeTableUrl;
end;

procedure TSketchClient.Set_AreaCodeTableUrl(const pRetVal: WideString);
  { Warning: The property AreaCodeTableUrl has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AreaCodeTableUrl := pRetVal;
end;

function TSketchClient.Get_IsAppRunning: WordBool;
begin
    Result := DefaultInterface.IsAppRunning;
end;

function TSketchClient.Get_AppPath: WideString;
begin
    Result := DefaultInterface.AppPath;
end;

procedure TSketchClient.Exit;
begin
  DefaultInterface.Exit;
end;

function TSketchClient.New: ISketch;
begin
  Result := DefaultInterface.New;
end;

function TSketchClient.NewAs(const path: WideString): ISketch;
begin
  Result := DefaultInterface.NewAs(path);
end;

function TSketchClient.Open(const path: WideString): ISketch;
begin
  Result := DefaultInterface.Open(path);
end;

function TSketchClient.OpenToPage(const path: WideString; pageIndex: Integer): ISketch;
begin
  Result := DefaultInterface.OpenToPage(path, pageIndex);
end;

function TSketchClient.OpenFromBase64String(const base64Sketch: WideString; pageIndex: Integer): ISketch;
begin
  Result := DefaultInterface.OpenFromBase64String(base64Sketch, pageIndex);
end;

function TSketchClient.SaveAsBase64String: WideString;
begin
  Result := DefaultInterface.SaveAsBase64String;
end;

procedure TSketchClient.ExportPageImages(const path: WideString; const options: WideString);
begin
  DefaultInterface.ExportPageImages(path, options);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSketchClientProperties.Create(AServer: TSketchClient);
begin
  inherited Create;
  FServer := AServer;
end;

function TSketchClientProperties.GetDefaultInterface: ISketchClient;
begin
  Result := FServer.DefaultInterface;
end;

function TSketchClientProperties.Get_Sketch: ISketch;
begin
    Result := DefaultInterface.Sketch;
end;

function TSketchClientProperties.Get_AreaCodeTableUrl: WideString;
begin
    Result := DefaultInterface.AreaCodeTableUrl;
end;

procedure TSketchClientProperties.Set_AreaCodeTableUrl(const pRetVal: WideString);
  { Warning: The property AreaCodeTableUrl has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AreaCodeTableUrl := pRetVal;
end;

function TSketchClientProperties.Get_IsAppRunning: WordBool;
begin
    Result := DefaultInterface.IsAppRunning;
end;

function TSketchClientProperties.Get_AppPath: WideString;
begin
    Result := DefaultInterface.AppPath;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TApexSketch, TSketchClient]);
end;

end.
