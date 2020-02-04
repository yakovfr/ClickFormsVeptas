unit AX1Lib_TLB;

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
// File generated on 1/19/2007 4:11:49 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms7\Tools\Imaging\AX1X.OCX (1)
// LIBID: {DE411201-289A-11D7-B381-00D009A439BF}
// LCID: 0
// Helpfile: 
// HelpString: Ax1 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
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
  AX1LibMajorVersion = 1;
  AX1LibMinorVersion = 0;

  LIBID_AX1Lib: TGUID = '{DE411201-289A-11D7-B381-00D009A439BF}';

  DIID__IAx1CtlEvents: TGUID = '{DE41120F-289A-11D7-B381-00D009A439BF}';
  IID_IAx1Ctl: TGUID = '{DE41120D-289A-11D7-B381-00D009A439BF}';
  CLASS_Ax1Ctl: TGUID = '{DE41120E-289A-11D7-B381-00D009A439BF}';
  CLASS_Ax1Page1: TGUID = '{462376C0-2C64-11D7-BD47-000021FC857F}';
  CLASS_Ax1Page2: TGUID = '{462376C1-2C64-11D7-BD47-000021FC857F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _IAx1CtlEvents = dispinterface;
  IAx1Ctl = interface;
  IAx1CtlDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Ax1Ctl = IAx1Ctl;
  Ax1Page1 = IUnknown;
  Ax1Page2 = IUnknown;


// *********************************************************************//
// DispIntf:  _IAx1CtlEvents
// Flags:     (4096) Dispatchable
// GUID:      {DE41120F-289A-11D7-B381-00D009A439BF}
// *********************************************************************//
  _IAx1CtlEvents = dispinterface
    ['{DE41120F-289A-11D7-B381-00D009A439BF}']
  end;

// *********************************************************************//
// Interface: IAx1Ctl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DE41120D-289A-11D7-B381-00D009A439BF}
// *********************************************************************//
  IAx1Ctl = interface(IDispatch)
    ['{DE41120D-289A-11D7-B381-00D009A439BF}']
    function Get_OutAxImage: Integer; safecall;
    function Get_OutBitmapHandle: Integer; safecall;
    function Get_OutBitmapInfo: Integer; safecall;
    function Get_OutBitsPerPixel: Integer; safecall;
    function Get_OutDpiX: Integer; safecall;
    function Get_OutDpiY: Integer; safecall;
    function Get_OutFillOrder: Integer; safecall;
    function Get_OutHeight: Integer; safecall;
    function Get_OutImageHandle: Integer; safecall;
    function Get_OutImagePointer: Integer; safecall;
    function Get_OutPageNumber: Integer; safecall;
    function Get_OutPageTotal: Integer; safecall;
    function Get_OutPlanes: Integer; safecall;
    function Get_OutWhiteDot: Integer; safecall;
    function Get_OutWidth: Integer; safecall;
    function Get_OutWidthBytes: Integer; safecall;
    function Get_ReadFileName: WideString; safecall;
    procedure Set_ReadFileName(const pVal: WideString); safecall;
    function Get_ReadSubFile: Integer; safecall;
    procedure Set_ReadSubFile(pVal: Integer); safecall;
    function Get_WriteFileName: WideString; safecall;
    procedure Set_WriteFileName(const pVal: WideString); safecall;
    function Read: Integer; safecall;
    function ReadBitmap: Integer; safecall;
    function ReadClear: Integer; safecall;
    function ReadCountSubfiles: Integer; safecall;
    function ReadDIB: Integer; safecall;
    function ReadHeader: Integer; safecall;
    function Write(pAxImage: Integer): Integer; safecall;
    function WriteBitmap(hBitmap: Integer; dpiX: Integer; dpiY: Integer): Integer; safecall;
    function WriteDIB(lpBitmapInfo: Integer; pBits: Integer; dpiX: Integer; dpiY: Integer): Integer; safecall;
    procedure AboutBox; safecall;
    property OutAxImage: Integer read Get_OutAxImage;
    property OutBitmapHandle: Integer read Get_OutBitmapHandle;
    property OutBitmapInfo: Integer read Get_OutBitmapInfo;
    property OutBitsPerPixel: Integer read Get_OutBitsPerPixel;
    property OutDpiX: Integer read Get_OutDpiX;
    property OutDpiY: Integer read Get_OutDpiY;
    property OutFillOrder: Integer read Get_OutFillOrder;
    property OutHeight: Integer read Get_OutHeight;
    property OutImageHandle: Integer read Get_OutImageHandle;
    property OutImagePointer: Integer read Get_OutImagePointer;
    property OutPageNumber: Integer read Get_OutPageNumber;
    property OutPageTotal: Integer read Get_OutPageTotal;
    property OutPlanes: Integer read Get_OutPlanes;
    property OutWhiteDot: Integer read Get_OutWhiteDot;
    property OutWidth: Integer read Get_OutWidth;
    property OutWidthBytes: Integer read Get_OutWidthBytes;
    property ReadFileName: WideString read Get_ReadFileName write Set_ReadFileName;
    property ReadSubFile: Integer read Get_ReadSubFile write Set_ReadSubFile;
    property WriteFileName: WideString read Get_WriteFileName write Set_WriteFileName;
  end;

// *********************************************************************//
// DispIntf:  IAx1CtlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DE41120D-289A-11D7-B381-00D009A439BF}
// *********************************************************************//
  IAx1CtlDisp = dispinterface
    ['{DE41120D-289A-11D7-B381-00D009A439BF}']
    property OutAxImage: Integer readonly dispid 1;
    property OutBitmapHandle: Integer readonly dispid 2;
    property OutBitmapInfo: Integer readonly dispid 3;
    property OutBitsPerPixel: Integer readonly dispid 4;
    property OutDpiX: Integer readonly dispid 5;
    property OutDpiY: Integer readonly dispid 6;
    property OutFillOrder: Integer readonly dispid 7;
    property OutHeight: Integer readonly dispid 8;
    property OutImageHandle: Integer readonly dispid 9;
    property OutImagePointer: Integer readonly dispid 10;
    property OutPageNumber: Integer readonly dispid 11;
    property OutPageTotal: Integer readonly dispid 12;
    property OutPlanes: Integer readonly dispid 13;
    property OutWhiteDot: Integer readonly dispid 14;
    property OutWidth: Integer readonly dispid 15;
    property OutWidthBytes: Integer readonly dispid 16;
    property ReadFileName: WideString dispid 17;
    property ReadSubFile: Integer dispid 18;
    property WriteFileName: WideString dispid 19;
    function Read: Integer; dispid 20;
    function ReadBitmap: Integer; dispid 21;
    function ReadClear: Integer; dispid 22;
    function ReadCountSubfiles: Integer; dispid 23;
    function ReadDIB: Integer; dispid 24;
    function ReadHeader: Integer; dispid 25;
    function Write(pAxImage: Integer): Integer; dispid 26;
    function WriteBitmap(hBitmap: Integer; dpiX: Integer; dpiY: Integer): Integer; dispid 27;
    function WriteDIB(lpBitmapInfo: Integer; pBits: Integer; dpiX: Integer; dpiY: Integer): Integer; dispid 28;
    procedure AboutBox; dispid -552;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAx1Ctl
// Help String      : Ax1Ctl Class
// Default Interface: IAx1Ctl
// Def. Intf. DISP? : No
// Event   Interface: _IAx1CtlEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TAx1Ctl = class(TOleControl)
  private
    FIntf: IAx1Ctl;
    function  GetControlInterface: IAx1Ctl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function Read: Integer;
    function ReadBitmap: Integer;
    function ReadClear: Integer;
    function ReadCountSubfiles: Integer;
    function ReadDIB: Integer;
    function ReadHeader: Integer;
    function Write(pAxImage: Integer): Integer;
    function WriteBitmap(hBitmap: Integer; dpiX: Integer; dpiY: Integer): Integer;
    function WriteDIB(lpBitmapInfo: Integer; pBits: Integer; dpiX: Integer; dpiY: Integer): Integer;
    procedure AboutBox;
    property  ControlInterface: IAx1Ctl read GetControlInterface;
    property  DefaultInterface: IAx1Ctl read GetControlInterface;
    property OutAxImage: Integer index 1 read GetIntegerProp;
    property OutBitmapHandle: Integer index 2 read GetIntegerProp;
    property OutBitmapInfo: Integer index 3 read GetIntegerProp;
    property OutBitsPerPixel: Integer index 4 read GetIntegerProp;
    property OutDpiX: Integer index 5 read GetIntegerProp;
    property OutDpiY: Integer index 6 read GetIntegerProp;
    property OutFillOrder: Integer index 7 read GetIntegerProp;
    property OutHeight: Integer index 8 read GetIntegerProp;
    property OutImageHandle: Integer index 9 read GetIntegerProp;
    property OutImagePointer: Integer index 10 read GetIntegerProp;
    property OutPageNumber: Integer index 11 read GetIntegerProp;
    property OutPageTotal: Integer index 12 read GetIntegerProp;
    property OutPlanes: Integer index 13 read GetIntegerProp;
    property OutWhiteDot: Integer index 14 read GetIntegerProp;
    property OutWidth: Integer index 15 read GetIntegerProp;
    property OutWidthBytes: Integer index 16 read GetIntegerProp;
  published
    property Anchors;
    property ReadFileName: WideString index 17 read GetWideStringProp write SetWideStringProp stored False;
    property ReadSubFile: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property WriteFileName: WideString index 19 read GetWideStringProp write SetWideStringProp stored False;
  end;

// *********************************************************************//
// The Class CoAx1Page1 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax1Page1. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx1Page1 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx1Page2 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax1Page2. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx1Page2 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TAx1Ctl.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{DE41120E-289A-11D7-B381-00D009A439BF}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TAx1Ctl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IAx1Ctl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAx1Ctl.GetControlInterface: IAx1Ctl;
begin
  CreateControl;
  Result := FIntf;
end;

function TAx1Ctl.Read: Integer;
begin
  Result := DefaultInterface.Read;
end;

function TAx1Ctl.ReadBitmap: Integer;
begin
  Result := DefaultInterface.ReadBitmap;
end;

function TAx1Ctl.ReadClear: Integer;
begin
  Result := DefaultInterface.ReadClear;
end;

function TAx1Ctl.ReadCountSubfiles: Integer;
begin
  Result := DefaultInterface.ReadCountSubfiles;
end;

function TAx1Ctl.ReadDIB: Integer;
begin
  Result := DefaultInterface.ReadDIB;
end;

function TAx1Ctl.ReadHeader: Integer;
begin
  Result := DefaultInterface.ReadHeader;
end;

function TAx1Ctl.Write(pAxImage: Integer): Integer;
begin
  Result := DefaultInterface.Write(pAxImage);
end;

function TAx1Ctl.WriteBitmap(hBitmap: Integer; dpiX: Integer; dpiY: Integer): Integer;
begin
  Result := DefaultInterface.WriteBitmap(hBitmap, dpiX, dpiY);
end;

function TAx1Ctl.WriteDIB(lpBitmapInfo: Integer; pBits: Integer; dpiX: Integer; dpiY: Integer): Integer;
begin
  Result := DefaultInterface.WriteDIB(lpBitmapInfo, pBits, dpiX, dpiY);
end;

procedure TAx1Ctl.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoAx1Page1.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax1Page1) as IUnknown;
end;

class function CoAx1Page1.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax1Page1) as IUnknown;
end;

class function CoAx1Page2.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax1Page2) as IUnknown;
end;

class function CoAx1Page2.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax1Page2) as IUnknown;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TAx1Ctl]);
end;

end.
