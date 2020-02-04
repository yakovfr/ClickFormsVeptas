unit LocationMap_Bradford_ClickForms_TLB;

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

// $Rev: 52393 $
// File generated on 3/31/2017 4:45:06 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\temp\LocationMap_Bradford_ClickForms\LocationMap_Bradford_ClickForms (1)
// LIBID: {B151A351-1A5B-497C-BDB1-E83CECC3D39C}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows,Classes, Variants, StdVCL, Graphics, OleServer, ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  LocationMap_Bradford_ClickFormsMajorVersion = 1;
  LocationMap_Bradford_ClickFormsMinorVersion = 3;

  LIBID_LocationMap_Bradford_ClickForms: TGUID = '{B151A351-1A5B-497C-BDB1-E83CECC3D39C}';

  IID_ILocationMapService: TGUID = '{534DA796-86B1-453A-8EAA-5F89ED8C0173}';
  DIID_ILocationMapServiceEvents: TGUID = '{916BCA3B-FFB4-4154-9885-D6274B3BEA08}';
  CLASS_LocationMapService: TGUID = '{A7467AD2-6A5D-4C52-97B2-CF9BFDC95D12}';
  IID_IExternalObject: TGUID = '{401C43D7-6432-4BB0-A4A8-14055A48A778}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ILocationMapService = interface;
  ILocationMapServiceDisp = dispinterface;
  ILocationMapServiceEvents = dispinterface;
  IExternalObject = interface;
  IExternalObjectDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  LocationMapService = ILocationMapService;


// *********************************************************************//
// Interface: ILocationMapService
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {534DA796-86B1-453A-8EAA-5F89ED8C0173}
// *********************************************************************//
  ILocationMapService = interface(IDispatch)
    ['{534DA796-86B1-453A-8EAA-5F89ED8C0173}']
    procedure AddAddressLabel(const id: WideString; type_: Integer; const caption: WideString;
                              const address: WideString; const unitno: WideString;
                              const locality: WideString; const adminDistrict: WideString;
                              const postalCode: WideString; const country: WideString;
                              const information: WideString; latitude: Double; longitude: Double;
                              const confidence: WideString; bitmap: PSafeArray); safecall;
    function GetAddressLabel(const id: WideString; out type_: Integer; out caption: WideString;
                             out address: WideString; out unitno: WideString;
                             out locality: WideString; out adminDistrict: WideString;
                             out postalCode: WideString; out country: WideString;
                             out information: WideString; out latitude: Double;
                             out longitude: Double; out confidence: WideString): Integer; stdcall;
    procedure Initialize(const settingsRegistryPath: WideString; const applicationUrl: WideString;
                         const applicationId: WideString; const countryFlag: WideString;
                         const mapState: WideString; mapWidth: Integer; mapHeight: Integer); safecall;
    procedure Show; safecall;
    function ShowDialog: Integer; stdcall;
    procedure Close; safecall;
    function test(const id: WideString; out type_: Integer): Integer; stdcall;
  end;

// *********************************************************************//
// DispIntf:  ILocationMapServiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {534DA796-86B1-453A-8EAA-5F89ED8C0173}
// *********************************************************************//
  ILocationMapServiceDisp = dispinterface
    ['{534DA796-86B1-453A-8EAA-5F89ED8C0173}']
    procedure AddAddressLabel(const id: WideString; type_: Integer; const caption: WideString;
                              const address: WideString; const unitno: WideString;
                              const locality: WideString; const adminDistrict: WideString;
                              const postalCode: WideString; const country: WideString;
                              const information: WideString; latitude: Double; longitude: Double;
                              const confidence: WideString;
                              bitmap: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 1;
    function GetAddressLabel(const id: WideString; out type_: Integer; out caption: WideString;
                             out address: WideString; out unitno: WideString;
                             out locality: WideString; out adminDistrict: WideString;
                             out postalCode: WideString; out country: WideString;
                             out information: WideString; out latitude: Double;
                             out longitude: Double; out confidence: WideString): Integer; dispid 2;
    procedure Initialize(const settingsRegistryPath: WideString; const applicationUrl: WideString;
                         const applicationId: WideString; const countryFlag: WideString;
                         const mapState: WideString; mapWidth: Integer; mapHeight: Integer); dispid 3;
    procedure Show; dispid 4;
    function ShowDialog: Integer; dispid 5;
    procedure Close; dispid 6;
    function test(const id: WideString; out type_: Integer): Integer; dispid 7;
  end;

// *********************************************************************//
// DispIntf:  ILocationMapServiceEvents
// Flags:     (0)
// GUID:      {916BCA3B-FFB4-4154-9885-D6274B3BEA08}
// *********************************************************************//
  ILocationMapServiceEvents = dispinterface
    ['{916BCA3B-FFB4-4154-9885-D6274B3BEA08}']
    function OnFormClosed: HResult; dispid 1;
    function OnMapCaptured(const mapState: WideString; const mapImage: WideString): HResult; dispid 2;
  end;

// *********************************************************************//
// Interface: IExternalObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {401C43D7-6432-4BB0-A4A8-14055A48A778}
// *********************************************************************//
  IExternalObject = interface(IDispatch)
    ['{401C43D7-6432-4BB0-A4A8-14055A48A778}']
    procedure scriptReady(const info: WideString); safecall;
    procedure saveLocationMap(const mapState: WideString); safecall;
    procedure closeForm; safecall;
    procedure exportImage; safecall;
    procedure savePreferences(const prefStr: WideString); safecall;
    procedure initCapture; safecall;
    procedure finalizeCapture; safecall;
  end;

// *********************************************************************//
// DispIntf:  IExternalObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {401C43D7-6432-4BB0-A4A8-14055A48A778}
// *********************************************************************//
  IExternalObjectDisp = dispinterface
    ['{401C43D7-6432-4BB0-A4A8-14055A48A778}']
    procedure scriptReady(const info: WideString); dispid 201;
    procedure saveLocationMap(const mapState: WideString); dispid 202;
    procedure closeForm; dispid 203;
    procedure exportImage; dispid 204;
    procedure savePreferences(const prefStr: WideString); dispid 205;
    procedure initCapture; dispid 206;
    procedure finalizeCapture; dispid 207;
  end;

// *********************************************************************//
// The Class CoLocationMapService provides a Create and CreateRemote method to
// create instances of the default interface ILocationMapService exposed by
// the CoClass LocationMapService. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoLocationMapService = class
    class function Create: ILocationMapService;
    class function CreateRemote(const MachineName: string): ILocationMapService;
  end;

implementation

uses ComObj;

class function CoLocationMapService.Create: ILocationMapService;
begin
  Result := CreateComObject(CLASS_LocationMapService) as ILocationMapService;
end;

class function CoLocationMapService.CreateRemote(const MachineName: string): ILocationMapService;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LocationMapService) as ILocationMapService;
end;

end.

