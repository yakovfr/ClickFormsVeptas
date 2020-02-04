unit AX7WLib_TLB;

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
// File generated on 1/5/2007 11:46:05 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms7\Tools\Imaging\AX7WX.OCX (1)
// LIBID: {229D3AC3-ECDF-11D6-BD46-000021FC857F}
// LCID: 0
// Helpfile: 
// HelpString: Ax7w 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
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
  AX7WLibMajorVersion = 1;
  AX7WLibMinorVersion = 0;

  LIBID_AX7WLib: TGUID = '{229D3AC3-ECDF-11D6-BD46-000021FC857F}';

  IID_IAx7wCtl: TGUID = '{229D3ACF-ECDF-11D6-BD46-000021FC857F}';
  CLASS_Ax7wCtl: TGUID = '{229D3AD0-ECDF-11D6-BD46-000021FC857F}';
  CLASS_Ax7wPage1: TGUID = '{229D3AD2-ECDF-11D6-BD46-000021FC857F}';
  CLASS_Ax7wPage2: TGUID = '{229D3AD3-ECDF-11D6-BD46-000021FC857F}';
  CLASS_Ax7wPage3: TGUID = '{229D3AD4-ECDF-11D6-BD46-000021FC857F}';
  CLASS_Ax7wPage4: TGUID = '{229D3AD5-ECDF-11D6-BD46-000021FC857F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAx7wCtl = interface;
  IAx7wCtlDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Ax7wCtl = IAx7wCtl;
  Ax7wPage1 = IUnknown;
  Ax7wPage2 = IUnknown;
  Ax7wPage3 = IUnknown;
  Ax7wPage4 = IUnknown;


// *********************************************************************//
// Interface: IAx7wCtl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {229D3ACF-ECDF-11D6-BD46-000021FC857F}
// *********************************************************************//
  IAx7wCtl = interface(IDispatch)
    ['{229D3ACF-ECDF-11D6-BD46-000021FC857F}']
    function Get_Bitmap: Integer; safecall;
    procedure Set_Bitmap(pVal: Integer); safecall;
    function Get_DpiX: Integer; safecall;
    procedure Set_DpiX(pVal: Integer); safecall;
    function Get_DpiY: Integer; safecall;
    procedure Set_DpiY(pVal: Integer); safecall;
    function Get_Units: Integer; safecall;
    procedure Set_Units(pVal: Integer); safecall;
    function Get_type_: Integer; safecall;
    procedure Set_type_(pVal: Integer); safecall;
    function Get_GroupTotal: Integer; safecall;
    procedure Set_GroupTotal(pVal: Integer); safecall;
    function Get_GroupNumber: Integer; safecall;
    procedure Set_GroupNumber(pVal: Integer); safecall;
    function Get_MsgAppendFlag: Integer; safecall;
    procedure Set_MsgAppendFlag(pVal: Integer); safecall;
    function Get_InitReaderFlag: Integer; safecall;
    procedure Set_InitReaderFlag(pVal: Integer); safecall;
    function Get_SizeX: Single; safecall;
    procedure Set_SizeX(pVal: Single); safecall;
    function Get_SizeY: Single; safecall;
    procedure Set_SizeY(pVal: Single); safecall;
    function Get_StartX: Single; safecall;
    procedure Set_StartX(pVal: Single); safecall;
    function Get_StartY: Single; safecall;
    procedure Set_StartY(pVal: Single); safecall;
    function Get_BufferCount: Integer; safecall;
    procedure Set_BufferCount(pVal: Integer); safecall;
    function Get_BarcodeBuffer: WideString; safecall;
    procedure Set_BarcodeBuffer(const pVal: WideString); safecall;
    function Get_JustifyVertical: Integer; safecall;
    procedure Set_JustifyVertical(pVal: Integer); safecall;
    function Get_JustifyHorrizontal: Integer; safecall;
    procedure Set_JustifyHorrizontal(pVal: Integer); safecall;
    function Get_ElementX: Integer; safecall;
    procedure Set_ElementX(pVal: Integer); safecall;
    function Get_BinaryModeFlag: Integer; safecall;
    procedure Set_BinaryModeFlag(pVal: Integer); safecall;
    function Get_RectangleOnlyFlag: Integer; safecall;
    procedure Set_RectangleOnlyFlag(pVal: Integer); safecall;
    function Get_OutSizeX: Single; safecall;
    procedure Set_OutSizeX(pVal: Single); safecall;
    function Get_OutSizeY: Single; safecall;
    procedure Set_OutSizeY(pVal: Single); safecall;
    function Write: Integer; safecall;
    function WriteBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer; safecall;
    function WriteDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer; safecall;
    function GetSymbolSize(DpiX: Integer; DpiY: Integer): Integer; safecall;
    procedure AboutBox; safecall;
    function Get_UseCustomColors: Integer; safecall;
    procedure Set_UseCustomColors(pVal: Integer); safecall;
    function Get_Transparent: Integer; safecall;
    procedure Set_Transparent(pVal: Integer); safecall;
    function Get_ColorBar: OLE_COLOR; safecall;
    procedure Set_ColorBar(pVal: OLE_COLOR); safecall;
    function Get_ColorSpace: OLE_COLOR; safecall;
    procedure Set_ColorSpace(pVal: OLE_COLOR); safecall;
    function Get_FileID: Integer; safecall;
    procedure Set_FileID(pVal: Integer); safecall;
    property Bitmap: Integer read Get_Bitmap write Set_Bitmap;
    property DpiX: Integer read Get_DpiX write Set_DpiX;
    property DpiY: Integer read Get_DpiY write Set_DpiY;
    property Units: Integer read Get_Units write Set_Units;
    property type_: Integer read Get_type_ write Set_type_;
    property GroupTotal: Integer read Get_GroupTotal write Set_GroupTotal;
    property GroupNumber: Integer read Get_GroupNumber write Set_GroupNumber;
    property MsgAppendFlag: Integer read Get_MsgAppendFlag write Set_MsgAppendFlag;
    property InitReaderFlag: Integer read Get_InitReaderFlag write Set_InitReaderFlag;
    property SizeX: Single read Get_SizeX write Set_SizeX;
    property SizeY: Single read Get_SizeY write Set_SizeY;
    property StartX: Single read Get_StartX write Set_StartX;
    property StartY: Single read Get_StartY write Set_StartY;
    property BufferCount: Integer read Get_BufferCount write Set_BufferCount;
    property BarcodeBuffer: WideString read Get_BarcodeBuffer write Set_BarcodeBuffer;
    property JustifyVertical: Integer read Get_JustifyVertical write Set_JustifyVertical;
    property JustifyHorrizontal: Integer read Get_JustifyHorrizontal write Set_JustifyHorrizontal;
    property ElementX: Integer read Get_ElementX write Set_ElementX;
    property BinaryModeFlag: Integer read Get_BinaryModeFlag write Set_BinaryModeFlag;
    property RectangleOnlyFlag: Integer read Get_RectangleOnlyFlag write Set_RectangleOnlyFlag;
    property OutSizeX: Single read Get_OutSizeX write Set_OutSizeX;
    property OutSizeY: Single read Get_OutSizeY write Set_OutSizeY;
    property UseCustomColors: Integer read Get_UseCustomColors write Set_UseCustomColors;
    property Transparent: Integer read Get_Transparent write Set_Transparent;
    property ColorBar: OLE_COLOR read Get_ColorBar write Set_ColorBar;
    property ColorSpace: OLE_COLOR read Get_ColorSpace write Set_ColorSpace;
    property FileID: Integer read Get_FileID write Set_FileID;
  end;

// *********************************************************************//
// DispIntf:  IAx7wCtlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {229D3ACF-ECDF-11D6-BD46-000021FC857F}
// *********************************************************************//
  IAx7wCtlDisp = dispinterface
    ['{229D3ACF-ECDF-11D6-BD46-000021FC857F}']
    property Bitmap: Integer dispid 1;
    property DpiX: Integer dispid 2;
    property DpiY: Integer dispid 3;
    property Units: Integer dispid 4;
    property type_: Integer dispid 5;
    property GroupTotal: Integer dispid 6;
    property GroupNumber: Integer dispid 7;
    property MsgAppendFlag: Integer dispid 8;
    property InitReaderFlag: Integer dispid 9;
    property SizeX: Single dispid 10;
    property SizeY: Single dispid 11;
    property StartX: Single dispid 12;
    property StartY: Single dispid 13;
    property BufferCount: Integer dispid 14;
    property BarcodeBuffer: WideString dispid 15;
    property JustifyVertical: Integer dispid 16;
    property JustifyHorrizontal: Integer dispid 17;
    property ElementX: Integer dispid 18;
    property BinaryModeFlag: Integer dispid 19;
    property RectangleOnlyFlag: Integer dispid 30;
    property OutSizeX: Single dispid 20;
    property OutSizeY: Single dispid 21;
    function Write: Integer; dispid 22;
    function WriteBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer; dispid 23;
    function WriteDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer; dispid 24;
    function GetSymbolSize(DpiX: Integer; DpiY: Integer): Integer; dispid 25;
    procedure AboutBox; dispid -552;
    property UseCustomColors: Integer dispid 26;
    property Transparent: Integer dispid 27;
    property ColorBar: OLE_COLOR dispid 28;
    property ColorSpace: OLE_COLOR dispid 29;
    property FileID: Integer dispid 31;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAx7wCtl
// Help String      : Ax7wCtl Class
// Default Interface: IAx7wCtl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TAx7wCtl = class(TOleControl)
  private
    FIntf: IAx7wCtl;
    function  GetControlInterface: IAx7wCtl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function Write: Integer;
    function WriteBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer;
    function WriteDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer;
    function GetSymbolSize(DpiX: Integer; DpiY: Integer): Integer;
    procedure AboutBox;
    property  ControlInterface: IAx7wCtl read GetControlInterface;
    property  DefaultInterface: IAx7wCtl read GetControlInterface;
  published
    property Anchors;
    property Bitmap: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
    property DpiX: Integer index 2 read GetIntegerProp write SetIntegerProp stored False;
    property DpiY: Integer index 3 read GetIntegerProp write SetIntegerProp stored False;
    property Units: Integer index 4 read GetIntegerProp write SetIntegerProp stored False;
    property type_: Integer index 5 read GetIntegerProp write SetIntegerProp stored False;
    property GroupTotal: Integer index 6 read GetIntegerProp write SetIntegerProp stored False;
    property GroupNumber: Integer index 7 read GetIntegerProp write SetIntegerProp stored False;
    property MsgAppendFlag: Integer index 8 read GetIntegerProp write SetIntegerProp stored False;
    property InitReaderFlag: Integer index 9 read GetIntegerProp write SetIntegerProp stored False;
    property SizeX: Single index 10 read GetSingleProp write SetSingleProp stored False;
    property SizeY: Single index 11 read GetSingleProp write SetSingleProp stored False;
    property StartX: Single index 12 read GetSingleProp write SetSingleProp stored False;
    property StartY: Single index 13 read GetSingleProp write SetSingleProp stored False;
    property BufferCount: Integer index 14 read GetIntegerProp write SetIntegerProp stored False;
    property BarcodeBuffer: WideString index 15 read GetWideStringProp write SetWideStringProp stored False;
    property JustifyVertical: Integer index 16 read GetIntegerProp write SetIntegerProp stored False;
    property JustifyHorrizontal: Integer index 17 read GetIntegerProp write SetIntegerProp stored False;
    property ElementX: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property BinaryModeFlag: Integer index 19 read GetIntegerProp write SetIntegerProp stored False;
    property RectangleOnlyFlag: Integer index 30 read GetIntegerProp write SetIntegerProp stored False;
    property OutSizeX: Single index 20 read GetSingleProp write SetSingleProp stored False;
    property OutSizeY: Single index 21 read GetSingleProp write SetSingleProp stored False;
    property UseCustomColors: Integer index 26 read GetIntegerProp write SetIntegerProp stored False;
    property Transparent: Integer index 27 read GetIntegerProp write SetIntegerProp stored False;
    property ColorBar: TColor index 28 read GetTColorProp write SetTColorProp stored False;
    property ColorSpace: TColor index 29 read GetTColorProp write SetTColorProp stored False;
    property FileID: Integer index 31 read GetIntegerProp write SetIntegerProp stored False;
  end;

// *********************************************************************//
// The Class CoAx7wPage1 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7wPage1. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7wPage1 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7wPage2 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7wPage2. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7wPage2 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7wPage3 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7wPage3. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7wPage3 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7wPage4 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7wPage4. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7wPage4 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TAx7wCtl.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{229D3AD0-ECDF-11D6-BD46-000021FC857F}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TAx7wCtl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IAx7wCtl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAx7wCtl.GetControlInterface: IAx7wCtl;
begin
  CreateControl;
  Result := FIntf;
end;

function TAx7wCtl.Write: Integer;
begin
  Result := DefaultInterface.Write;
end;

function TAx7wCtl.WriteBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer;
begin
  Result := DefaultInterface.WriteBitmap(hBitmap, DpiX, DpiY);
end;

function TAx7wCtl.WriteDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer;
begin
  Result := DefaultInterface.WriteDIB(pBitmapInfo, pBits, DpiX, DpiY);
end;

function TAx7wCtl.GetSymbolSize(DpiX: Integer; DpiY: Integer): Integer;
begin
  Result := DefaultInterface.GetSymbolSize(DpiX, DpiY);
end;

procedure TAx7wCtl.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoAx7wPage1.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7wPage1) as IUnknown;
end;

class function CoAx7wPage1.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7wPage1) as IUnknown;
end;

class function CoAx7wPage2.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7wPage2) as IUnknown;
end;

class function CoAx7wPage2.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7wPage2) as IUnknown;
end;

class function CoAx7wPage3.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7wPage3) as IUnknown;
end;

class function CoAx7wPage3.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7wPage3) as IUnknown;
end;

class function CoAx7wPage4.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7wPage4) as IUnknown;
end;

class function CoAx7wPage4.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7wPage4) as IUnknown;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TAx7wCtl]);
end;

end.
