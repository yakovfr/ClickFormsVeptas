unit ASPILib_TLB;

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
// File generated on 2/27/2007 2:34:49 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Program Files\AreaSketch Pro\ASPI.exe (1)
// LIBID: {74D6204C-48F4-4F2B-9D02-6E2B33A3D915}
// LCID: 0
// Helpfile: 
// HelpString: ASPI 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TConnector) : Server D:\PROGRA~1\AREASK~1\ASPI.exe contains no icons
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

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ASPILibMajorVersion = 1;
  ASPILibMinorVersion = 0;

  LIBID_ASPILib: TGUID = '{74D6204C-48F4-4F2B-9D02-6E2B33A3D915}';

  IID_IConnector: TGUID = '{65389634-A564-462E-9FFF-37D2435D1CA0}';
  CLASS_Connector: TGUID = '{015CB9E3-6197-489E-A3FC-9606FFA5DC54}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IConnector = interface;
  IConnectorDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Connector = IConnector;


// *********************************************************************//
// Interface: IConnector
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65389634-A564-462E-9FFF-37D2435D1CA0}
// *********************************************************************//
  IConnector = interface(IDispatch)
    ['{65389634-A564-462E-9FFF-37D2435D1CA0}']
    function Get_WorkingDir: WideString; safecall;
    procedure Set_WorkingDir(const pVal: WideString); safecall;
    function Get_VendorId: WideString; safecall;
    procedure Set_VendorId(const pVal: WideString); safecall;
    function Get_ErrorText: WideString; safecall;
    procedure Set_ErrorText(const pVal: WideString); safecall;
    procedure StartSketching; safecall;
    function WaitForSketchDone: Integer; safecall;
    procedure SketchDone(modified: Integer); safecall;
    function Get_SketchFile: WideString; safecall;
    procedure Set_SketchFile(const pVal: WideString); safecall;
    property WorkingDir: WideString read Get_WorkingDir write Set_WorkingDir;
    property VendorId: WideString read Get_VendorId write Set_VendorId;
    property ErrorText: WideString read Get_ErrorText write Set_ErrorText;
    property SketchFile: WideString read Get_SketchFile write Set_SketchFile;
  end;

// *********************************************************************//
// DispIntf:  IConnectorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65389634-A564-462E-9FFF-37D2435D1CA0}
// *********************************************************************//
  IConnectorDisp = dispinterface
    ['{65389634-A564-462E-9FFF-37D2435D1CA0}']
    property WorkingDir: WideString dispid 1;
    property VendorId: WideString dispid 2;
    property ErrorText: WideString dispid 3;
    procedure StartSketching; dispid 4;
    function WaitForSketchDone: Integer; dispid 5;
    procedure SketchDone(modified: Integer); dispid 6;
    property SketchFile: WideString dispid 7;
  end;

// *********************************************************************//
// The Class CoConnector provides a Create and CreateRemote method to          
// create instances of the default interface IConnector exposed by              
// the CoClass Connector. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoConnector = class
    class function Create: IConnector;
    class function CreateRemote(const MachineName: string): IConnector;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TConnector
// Help String      : AreaSketch Pro Connector Class
// Default Interface: IConnector
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TConnectorProperties= class;
{$ENDIF}
  TConnector = class(TOleServer)
  private
    FIntf:        IConnector;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TConnectorProperties;
    function      GetServerProperties: TConnectorProperties;
{$ENDIF}
    function      GetDefaultInterface: IConnector;
  protected
    procedure InitServerData; override;
    function Get_WorkingDir: WideString;
    procedure Set_WorkingDir(const pVal: WideString);
    function Get_VendorId: WideString;
    procedure Set_VendorId(const pVal: WideString);
    function Get_ErrorText: WideString;
    procedure Set_ErrorText(const pVal: WideString);
    function Get_SketchFile: WideString;
    procedure Set_SketchFile(const pVal: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IConnector);
    procedure Disconnect; override;
    procedure StartSketching;
    function WaitForSketchDone: Integer;
    procedure SketchDone(modified: Integer);
    property DefaultInterface: IConnector read GetDefaultInterface;
    property WorkingDir: WideString read Get_WorkingDir write Set_WorkingDir;
    property VendorId: WideString read Get_VendorId write Set_VendorId;
    property ErrorText: WideString read Get_ErrorText write Set_ErrorText;
    property SketchFile: WideString read Get_SketchFile write Set_SketchFile;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TConnectorProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TConnector
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TConnectorProperties = class(TPersistent)
  private
    FServer:    TConnector;
    function    GetDefaultInterface: IConnector;
    constructor Create(AServer: TConnector);
  protected
    function Get_WorkingDir: WideString;
    procedure Set_WorkingDir(const pVal: WideString);
    function Get_VendorId: WideString;
    procedure Set_VendorId(const pVal: WideString);
    function Get_ErrorText: WideString;
    procedure Set_ErrorText(const pVal: WideString);
    function Get_SketchFile: WideString;
    procedure Set_SketchFile(const pVal: WideString);
  public
    property DefaultInterface: IConnector read GetDefaultInterface;
  published
    property WorkingDir: WideString read Get_WorkingDir write Set_WorkingDir;
    property VendorId: WideString read Get_VendorId write Set_VendorId;
    property ErrorText: WideString read Get_ErrorText write Set_ErrorText;
    property SketchFile: WideString read Get_SketchFile write Set_SketchFile;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoConnector.Create: IConnector;
begin
  Result := CreateComObject(CLASS_Connector) as IConnector;
end;

class function CoConnector.CreateRemote(const MachineName: string): IConnector;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Connector) as IConnector;
end;

procedure TConnector.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{015CB9E3-6197-489E-A3FC-9606FFA5DC54}';
    IntfIID:   '{65389634-A564-462E-9FFF-37D2435D1CA0}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TConnector.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IConnector;
  end;
end;

procedure TConnector.ConnectTo(svrIntf: IConnector);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TConnector.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TConnector.GetDefaultInterface: IConnector;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TConnector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TConnectorProperties.Create(Self);
{$ENDIF}
end;

destructor TConnector.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TConnector.GetServerProperties: TConnectorProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TConnector.Get_WorkingDir: WideString;
begin
    Result := DefaultInterface.WorkingDir;
end;

procedure TConnector.Set_WorkingDir(const pVal: WideString);
  { Warning: The property WorkingDir has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.WorkingDir := pVal;
end;

function TConnector.Get_VendorId: WideString;
begin
    Result := DefaultInterface.VendorId;
end;

procedure TConnector.Set_VendorId(const pVal: WideString);
  { Warning: The property VendorId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.VendorId := pVal;
end;

function TConnector.Get_ErrorText: WideString;
begin
    Result := DefaultInterface.ErrorText;
end;

procedure TConnector.Set_ErrorText(const pVal: WideString);
  { Warning: The property ErrorText has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ErrorText := pVal;
end;

function TConnector.Get_SketchFile: WideString;
begin
    Result := DefaultInterface.SketchFile;
end;

procedure TConnector.Set_SketchFile(const pVal: WideString);
  { Warning: The property SketchFile has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SketchFile := pVal;
end;

procedure TConnector.StartSketching;
begin
  DefaultInterface.StartSketching;
end;

function TConnector.WaitForSketchDone: Integer;
begin
  Result := DefaultInterface.WaitForSketchDone;
end;

procedure TConnector.SketchDone(modified: Integer);
begin
  DefaultInterface.SketchDone(modified);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TConnectorProperties.Create(AServer: TConnector);
begin
  inherited Create;
  FServer := AServer;
end;

function TConnectorProperties.GetDefaultInterface: IConnector;
begin
  Result := FServer.DefaultInterface;
end;

function TConnectorProperties.Get_WorkingDir: WideString;
begin
    Result := DefaultInterface.WorkingDir;
end;

procedure TConnectorProperties.Set_WorkingDir(const pVal: WideString);
  { Warning: The property WorkingDir has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.WorkingDir := pVal;
end;

function TConnectorProperties.Get_VendorId: WideString;
begin
    Result := DefaultInterface.VendorId;
end;

procedure TConnectorProperties.Set_VendorId(const pVal: WideString);
  { Warning: The property VendorId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.VendorId := pVal;
end;

function TConnectorProperties.Get_ErrorText: WideString;
begin
    Result := DefaultInterface.ErrorText;
end;

procedure TConnectorProperties.Set_ErrorText(const pVal: WideString);
  { Warning: The property ErrorText has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ErrorText := pVal;
end;

function TConnectorProperties.Get_SketchFile: WideString;
begin
    Result := DefaultInterface.SketchFile;
end;

procedure TConnectorProperties.Set_SketchFile(const pVal: WideString);
  { Warning: The property SketchFile has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SketchFile := pVal;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TConnector]);
end;

end.
