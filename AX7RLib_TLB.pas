unit AX7RLib_TLB;

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
// File generated on 1/5/2007 11:45:07 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms7\Tools\Imaging\AX7RX.OCX (1)
// LIBID: {8B143649-9479-46CB-968C-A6B95A66F14A}
// LCID: 0
// Helpfile: 
// HelpString: Ax7r 1.0 Type Library
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
  AX7RLibMajorVersion = 1;
  AX7RLibMinorVersion = 0;

  LIBID_AX7RLib: TGUID = '{8B143649-9479-46CB-968C-A6B95A66F14A}';

  IID_IAx7rCtl: TGUID = '{97588A9F-DE02-4C4C-AEA6-2C5593E2830A}';
  CLASS_Ax7rCtl: TGUID = '{2FD46CF4-8EFB-4691-BA90-8F5F6198505D}';
  CLASS_Ax7rPage1: TGUID = '{82555FA0-E281-11D6-BD46-000021FC857F}';
  CLASS_Ax7rPage3: TGUID = '{EBAA6381-E2A2-11D6-BD46-000021FC857F}';
  CLASS_Ax7rPage4: TGUID = '{EBAA6382-E2A2-11D6-BD46-000021FC857F}';
  CLASS_Ax7rPage2: TGUID = '{69543860-E5A5-11D6-BD46-000021FC857F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAx7rCtl = interface;
  IAx7rCtlDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Ax7rCtl = IAx7rCtl;
  Ax7rPage1 = IUnknown;
  Ax7rPage3 = IUnknown;
  Ax7rPage4 = IUnknown;
  Ax7rPage2 = IUnknown;


// *********************************************************************//
// Interface: IAx7rCtl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {97588A9F-DE02-4C4C-AEA6-2C5593E2830A}
// *********************************************************************//
  IAx7rCtl = interface(IDispatch)
    ['{97588A9F-DE02-4C4C-AEA6-2C5593E2830A}']
    function Get_Bitmap: Integer; safecall;
    procedure Set_Bitmap(pVal: Integer); safecall;
    function Get_DpiX: Integer; safecall;
    procedure Set_DpiX(pVal: Integer); safecall;
    function Get_DpiY: Integer; safecall;
    procedure Set_DpiY(pVal: Integer); safecall;
    function Get_Units: Integer; safecall;
    procedure Set_Units(pVal: Integer); safecall;
    function Get_MultipleMax: Integer; safecall;
    procedure Set_MultipleMax(pVal: Integer); safecall;
    function Get_StartX: Single; safecall;
    procedure Set_StartX(pVal: Single); safecall;
    function Get_StartY: Single; safecall;
    procedure Set_StartY(pVal: Single); safecall;
    function Get_SizeX: Single; safecall;
    procedure Set_SizeX(pVal: Single); safecall;
    function Get_SizeY: Single; safecall;
    procedure Set_SizeY(pVal: Single); safecall;
    function Get_OutMultipleCount: Integer; safecall;
    function Get_OutStatus: Integer; safecall;
    function Get_OutUnits: Integer; safecall;
    function Get_OutSizeofData: Integer; safecall;
    function Get_OutBarcodeData: WideString; safecall;
    function Get_OutStartX: Single; safecall;
    function Get_OutStartY: Single; safecall;
    function Get_OutSizeX: Single; safecall;
    function Get_OutSizeY: Single; safecall;
    function Get_OutIndex: Integer; safecall;
    procedure Set_OutIndex(pVal: Integer); safecall;
    function Get_SearchTypeSquare: Integer; safecall;
    procedure Set_SearchTypeSquare(pVal: Integer); safecall;
    function Get_SearchTypeRectangular: Integer; safecall;
    procedure Set_SearchTypeRectangular(pVal: Integer); safecall;
    function Get_SearchTypeSmall: Integer; safecall;
    procedure Set_SearchTypeSmall(pVal: Integer); safecall;
    function Get_SymbologyID: Integer; safecall;
    procedure Set_SymbologyID(pVal: Integer); safecall;
    function Get_OutType: Integer; safecall;
    function Get_OutFileID: Integer; safecall;
    function Get_OutGroupNumber: Integer; safecall;
    function Get_OutGroupTotal: Integer; safecall;
    function Read: Integer; safecall;
    procedure ClearRead; safecall;
    function ReadBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer; safecall;
    function ReadDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer; safecall;
    procedure AboutBox; safecall;
    function Get_UseCustomColors: Integer; safecall;
    procedure Set_UseCustomColors(pVal: Integer); safecall;
    function Get_ColorBar: OLE_COLOR; safecall;
    procedure Set_ColorBar(pVal: OLE_COLOR); safecall;
    function Get_ColorSpace: OLE_COLOR; safecall;
    procedure Set_ColorSpace(pVal: OLE_COLOR); safecall;
    function Get_OutGrade: Integer; safecall;
    function Get_ReturnCorrupted: Integer; safecall;
    procedure Set_ReturnCorrupted(pVal: Integer); safecall;
    function Get_Subfile: Integer; safecall;
    procedure Set_Subfile(pVal: Integer); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const pVal: WideString); safecall;
    function ReadFile: Integer; safecall;
    function Get_FastFindDisable: Integer; safecall;
    procedure Set_FastFindDisable(pVal: Integer); safecall;
    function Get_CvtDisable: Integer; safecall;
    procedure Set_CvtDisable(pVal: Integer); safecall;
    function Get_ForceInvert: Integer; safecall;
    procedure Set_ForceInvert(pVal: Integer); safecall;
    function Get_OutX1: Single; safecall;
    function Get_OutY1: Single; safecall;
    function Get_OutX2: Single; safecall;
    function Get_OutY2: Single; safecall;
    function Get_OutX3: Single; safecall;
    function Get_OutY3: Single; safecall;
    function Get_OutX4: Single; safecall;
    function Get_OutY4: Single; safecall;
    property Bitmap: Integer read Get_Bitmap write Set_Bitmap;
    property DpiX: Integer read Get_DpiX write Set_DpiX;
    property DpiY: Integer read Get_DpiY write Set_DpiY;
    property Units: Integer read Get_Units write Set_Units;
    property MultipleMax: Integer read Get_MultipleMax write Set_MultipleMax;
    property StartX: Single read Get_StartX write Set_StartX;
    property StartY: Single read Get_StartY write Set_StartY;
    property SizeX: Single read Get_SizeX write Set_SizeX;
    property SizeY: Single read Get_SizeY write Set_SizeY;
    property OutMultipleCount: Integer read Get_OutMultipleCount;
    property OutStatus: Integer read Get_OutStatus;
    property OutUnits: Integer read Get_OutUnits;
    property OutSizeofData: Integer read Get_OutSizeofData;
    property OutBarcodeData: WideString read Get_OutBarcodeData;
    property OutStartX: Single read Get_OutStartX;
    property OutStartY: Single read Get_OutStartY;
    property OutSizeX: Single read Get_OutSizeX;
    property OutSizeY: Single read Get_OutSizeY;
    property OutIndex: Integer read Get_OutIndex write Set_OutIndex;
    property SearchTypeSquare: Integer read Get_SearchTypeSquare write Set_SearchTypeSquare;
    property SearchTypeRectangular: Integer read Get_SearchTypeRectangular write Set_SearchTypeRectangular;
    property SearchTypeSmall: Integer read Get_SearchTypeSmall write Set_SearchTypeSmall;
    property SymbologyID: Integer read Get_SymbologyID write Set_SymbologyID;
    property OutType: Integer read Get_OutType;
    property OutFileID: Integer read Get_OutFileID;
    property OutGroupNumber: Integer read Get_OutGroupNumber;
    property OutGroupTotal: Integer read Get_OutGroupTotal;
    property UseCustomColors: Integer read Get_UseCustomColors write Set_UseCustomColors;
    property ColorBar: OLE_COLOR read Get_ColorBar write Set_ColorBar;
    property ColorSpace: OLE_COLOR read Get_ColorSpace write Set_ColorSpace;
    property OutGrade: Integer read Get_OutGrade;
    property ReturnCorrupted: Integer read Get_ReturnCorrupted write Set_ReturnCorrupted;
    property Subfile: Integer read Get_Subfile write Set_Subfile;
    property FileName: WideString read Get_FileName write Set_FileName;
    property FastFindDisable: Integer read Get_FastFindDisable write Set_FastFindDisable;
    property CvtDisable: Integer read Get_CvtDisable write Set_CvtDisable;
    property ForceInvert: Integer read Get_ForceInvert write Set_ForceInvert;
    property OutX1: Single read Get_OutX1;
    property OutY1: Single read Get_OutY1;
    property OutX2: Single read Get_OutX2;
    property OutY2: Single read Get_OutY2;
    property OutX3: Single read Get_OutX3;
    property OutY3: Single read Get_OutY3;
    property OutX4: Single read Get_OutX4;
    property OutY4: Single read Get_OutY4;
  end;

// *********************************************************************//
// DispIntf:  IAx7rCtlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {97588A9F-DE02-4C4C-AEA6-2C5593E2830A}
// *********************************************************************//
  IAx7rCtlDisp = dispinterface
    ['{97588A9F-DE02-4C4C-AEA6-2C5593E2830A}']
    property Bitmap: Integer dispid 1;
    property DpiX: Integer dispid 2;
    property DpiY: Integer dispid 3;
    property Units: Integer dispid 4;
    property MultipleMax: Integer dispid 5;
    property StartX: Single dispid 6;
    property StartY: Single dispid 7;
    property SizeX: Single dispid 8;
    property SizeY: Single dispid 9;
    property OutMultipleCount: Integer readonly dispid 10;
    property OutStatus: Integer readonly dispid 11;
    property OutUnits: Integer readonly dispid 12;
    property OutSizeofData: Integer readonly dispid 13;
    property OutBarcodeData: WideString readonly dispid 14;
    property OutStartX: Single readonly dispid 15;
    property OutStartY: Single readonly dispid 16;
    property OutSizeX: Single readonly dispid 17;
    property OutSizeY: Single readonly dispid 18;
    property OutIndex: Integer dispid 19;
    property SearchTypeSquare: Integer dispid 20;
    property SearchTypeRectangular: Integer dispid 21;
    property SearchTypeSmall: Integer dispid 22;
    property SymbologyID: Integer dispid 23;
    property OutType: Integer readonly dispid 24;
    property OutFileID: Integer readonly dispid 25;
    property OutGroupNumber: Integer readonly dispid 26;
    property OutGroupTotal: Integer readonly dispid 27;
    function Read: Integer; dispid 28;
    procedure ClearRead; dispid 29;
    function ReadBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer; dispid 30;
    function ReadDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer; dispid 31;
    procedure AboutBox; dispid -552;
    property UseCustomColors: Integer dispid 32;
    property ColorBar: OLE_COLOR dispid 33;
    property ColorSpace: OLE_COLOR dispid 34;
    property OutGrade: Integer readonly dispid 35;
    property ReturnCorrupted: Integer dispid 36;
    property Subfile: Integer dispid 37;
    property FileName: WideString dispid 38;
    function ReadFile: Integer; dispid 39;
    property FastFindDisable: Integer dispid 42;
    property CvtDisable: Integer dispid 41;
    property ForceInvert: Integer dispid 40;
    property OutX1: Single readonly dispid 43;
    property OutY1: Single readonly dispid 44;
    property OutX2: Single readonly dispid 45;
    property OutY2: Single readonly dispid 46;
    property OutX3: Single readonly dispid 47;
    property OutY3: Single readonly dispid 48;
    property OutX4: Single readonly dispid 49;
    property OutY4: Single readonly dispid 50;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAx7rCtl
// Help String      : Ax7rCtl Class
// Default Interface: IAx7rCtl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TAx7rCtl = class(TOleControl)
  private
    FIntf: IAx7rCtl;
    function  GetControlInterface: IAx7rCtl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function Read: Integer;
    procedure ClearRead;
    function ReadBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer;
    function ReadDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer;
    procedure AboutBox;
    function ReadFile: Integer;
    property  ControlInterface: IAx7rCtl read GetControlInterface;
    property  DefaultInterface: IAx7rCtl read GetControlInterface;
    property OutMultipleCount: Integer index 10 read GetIntegerProp;
    property OutStatus: Integer index 11 read GetIntegerProp;
    property OutUnits: Integer index 12 read GetIntegerProp;
    property OutSizeofData: Integer index 13 read GetIntegerProp;
    property OutBarcodeData: WideString index 14 read GetWideStringProp;
    property OutStartX: Single index 15 read GetSingleProp;
    property OutStartY: Single index 16 read GetSingleProp;
    property OutSizeX: Single index 17 read GetSingleProp;
    property OutSizeY: Single index 18 read GetSingleProp;
    property OutType: Integer index 24 read GetIntegerProp;
    property OutFileID: Integer index 25 read GetIntegerProp;
    property OutGroupNumber: Integer index 26 read GetIntegerProp;
    property OutGroupTotal: Integer index 27 read GetIntegerProp;
    property OutGrade: Integer index 35 read GetIntegerProp;
    property OutX1: Single index 43 read GetSingleProp;
    property OutY1: Single index 44 read GetSingleProp;
    property OutX2: Single index 45 read GetSingleProp;
    property OutY2: Single index 46 read GetSingleProp;
    property OutX3: Single index 47 read GetSingleProp;
    property OutY3: Single index 48 read GetSingleProp;
    property OutX4: Single index 49 read GetSingleProp;
    property OutY4: Single index 50 read GetSingleProp;
  published
    property Anchors;
    property Bitmap: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
    property DpiX: Integer index 2 read GetIntegerProp write SetIntegerProp stored False;
    property DpiY: Integer index 3 read GetIntegerProp write SetIntegerProp stored False;
    property Units: Integer index 4 read GetIntegerProp write SetIntegerProp stored False;
    property MultipleMax: Integer index 5 read GetIntegerProp write SetIntegerProp stored False;
    property StartX: Single index 6 read GetSingleProp write SetSingleProp stored False;
    property StartY: Single index 7 read GetSingleProp write SetSingleProp stored False;
    property SizeX: Single index 8 read GetSingleProp write SetSingleProp stored False;
    property SizeY: Single index 9 read GetSingleProp write SetSingleProp stored False;
    property OutIndex: Integer index 19 read GetIntegerProp write SetIntegerProp stored False;
    property SearchTypeSquare: Integer index 20 read GetIntegerProp write SetIntegerProp stored False;
    property SearchTypeRectangular: Integer index 21 read GetIntegerProp write SetIntegerProp stored False;
    property SearchTypeSmall: Integer index 22 read GetIntegerProp write SetIntegerProp stored False;
    property SymbologyID: Integer index 23 read GetIntegerProp write SetIntegerProp stored False;
    property UseCustomColors: Integer index 32 read GetIntegerProp write SetIntegerProp stored False;
    property ColorBar: TColor index 33 read GetTColorProp write SetTColorProp stored False;
    property ColorSpace: TColor index 34 read GetTColorProp write SetTColorProp stored False;
    property ReturnCorrupted: Integer index 36 read GetIntegerProp write SetIntegerProp stored False;
    property Subfile: Integer index 37 read GetIntegerProp write SetIntegerProp stored False;
    property FileName: WideString index 38 read GetWideStringProp write SetWideStringProp stored False;
    property FastFindDisable: Integer index 42 read GetIntegerProp write SetIntegerProp stored False;
    property CvtDisable: Integer index 41 read GetIntegerProp write SetIntegerProp stored False;
    property ForceInvert: Integer index 40 read GetIntegerProp write SetIntegerProp stored False;
  end;

// *********************************************************************//
// The Class CoAx7rPage1 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7rPage1. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7rPage1 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7rPage3 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7rPage3. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7rPage3 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7rPage4 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7rPage4. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7rPage4 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoAx7rPage2 provides a Create and CreateRemote method to          
// create instances of the default interface IUnknown exposed by              
// the CoClass Ax7rPage2. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAx7rPage2 = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TAx7rCtl.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{2FD46CF4-8EFB-4691-BA90-8F5F6198505D}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TAx7rCtl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IAx7rCtl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAx7rCtl.GetControlInterface: IAx7rCtl;
begin
  CreateControl;
  Result := FIntf;
end;

function TAx7rCtl.Read: Integer;
begin
  Result := DefaultInterface.Read;
end;

procedure TAx7rCtl.ClearRead;
begin
  DefaultInterface.ClearRead;
end;

function TAx7rCtl.ReadBitmap(hBitmap: Integer; DpiX: Integer; DpiY: Integer): Integer;
begin
  Result := DefaultInterface.ReadBitmap(hBitmap, DpiX, DpiY);
end;

function TAx7rCtl.ReadDIB(pBitmapInfo: Integer; pBits: Integer; DpiX: Integer; DpiY: Integer): Integer;
begin
  Result := DefaultInterface.ReadDIB(pBitmapInfo, pBits, DpiX, DpiY);
end;

procedure TAx7rCtl.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TAx7rCtl.ReadFile: Integer;
begin
  Result := DefaultInterface.ReadFile;
end;

class function CoAx7rPage1.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7rPage1) as IUnknown;
end;

class function CoAx7rPage1.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7rPage1) as IUnknown;
end;

class function CoAx7rPage3.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7rPage3) as IUnknown;
end;

class function CoAx7rPage3.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7rPage3) as IUnknown;
end;

class function CoAx7rPage4.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7rPage4) as IUnknown;
end;

class function CoAx7rPage4.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7rPage4) as IUnknown;
end;

class function CoAx7rPage2.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_Ax7rPage2) as IUnknown;
end;

class function CoAx7rPage2.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Ax7rPage2) as IUnknown;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TAx7rCtl]);
end;

end.
