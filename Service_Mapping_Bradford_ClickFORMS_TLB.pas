unit Service_Mapping_Bradford_ClickFORMS_TLB;

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
// File generated on 8/27/2019 11:46:47 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Github\VS2017-Bing-Online-Map-DLL Canada\Output\Service.Mapping.Bradford.ClickFORMS.dll (1)
// LIBID: {161A6680-AF57-4D9C-AE14-F000AFAD243B}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Parameter 'type' of ILocationMapService.AddAddressLabel changed to 'type_'
//   Hint: Parameter 'type' of ILocationMapService.GetAddressLabel changed to 'type_'
//   Error creating palette bitmap of (TMapCapturedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TMapFormClosedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TLocationMapService) : Server mscoree.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, mscorlib_TLB, Classes, Variants, StdVCL, Graphics, OleServer, ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Service_Mapping_Bradford_ClickFORMSMajorVersion = 2;
  Service_Mapping_Bradford_ClickFORMSMinorVersion = 3;

  LIBID_Service_Mapping_Bradford_ClickFORMS: TGUID = '{161A6680-AF57-4D9C-AE14-F000AFAD243B}';

  IID__MapCapturedEventHandler: TGUID = '{FD13A46C-78F4-3EC6-8601-DF64C376FB66}';
  IID__MapFormClosedEventHandler: TGUID = '{BC5CE198-9228-3286-9677-EB78C793CBB2}';
  IID_ILocationMapService: TGUID = '{7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}';
  IID_ILocationMapServiceEvents: TGUID = '{F03C34F5-CDD3-4558-8895-1A81C535CD8F}';
  CLASS_LocationMapService: TGUID = '{33CC5481-1B8E-49CF-A109-BD3B414ED540}';
  CLASS_MapCapturedEventHandler: TGUID = '{8947771E-4BC3-3F97-8B5C-D7D5E681EA06}';
  CLASS_MapFormClosedEventHandler: TGUID = '{82324714-FCFA-31AF-A3F5-411AC16B8A39}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _MapCapturedEventHandler = interface;
  _MapCapturedEventHandlerDisp = dispinterface;
  _MapFormClosedEventHandler = interface;
  _MapFormClosedEventHandlerDisp = dispinterface;
  ILocationMapService = interface;
  ILocationMapServiceDisp = dispinterface;
  ILocationMapServiceEvents = interface;
  ILocationMapServiceEventsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  LocationMapService = ILocationMapService;
  MapCapturedEventHandler = _MapCapturedEventHandler;
  MapFormClosedEventHandler = _MapFormClosedEventHandler;


// *********************************************************************//
// Interface: _MapCapturedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FD13A46C-78F4-3EC6-8601-DF64C376FB66}
// *********************************************************************//
  _MapCapturedEventHandler = interface(IDispatch)
    ['{FD13A46C-78F4-3EC6-8601-DF64C376FB66}']
  end;

// *********************************************************************//
// DispIntf:  _MapCapturedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FD13A46C-78F4-3EC6-8601-DF64C376FB66}
// *********************************************************************//
  _MapCapturedEventHandlerDisp = dispinterface
    ['{FD13A46C-78F4-3EC6-8601-DF64C376FB66}']
  end;

// *********************************************************************//
// Interface: _MapFormClosedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BC5CE198-9228-3286-9677-EB78C793CBB2}
// *********************************************************************//
  _MapFormClosedEventHandler = interface(IDispatch)
    ['{BC5CE198-9228-3286-9677-EB78C793CBB2}']
  end;

// *********************************************************************//
// DispIntf:  _MapFormClosedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BC5CE198-9228-3286-9677-EB78C793CBB2}
// *********************************************************************//
  _MapFormClosedEventHandlerDisp = dispinterface
    ['{BC5CE198-9228-3286-9677-EB78C793CBB2}']
  end;

// *********************************************************************//
// Interface: ILocationMapService
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}
// *********************************************************************//
  ILocationMapService = interface(IDispatch)
    ['{7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}']
    procedure AddAddressLabel(const id: WideString; type_: Integer; const caption: WideString; 
                              const address: WideString; const locality: WideString; 
                              const adminDistrict: WideString; const postalCode: WideString; 
                              const country: WideString; const information: WideString; 
                              latitude: Double; longitude: Double; const confidence: WideString; 
                              bitmap: PSafeArray); safecall;
    function GetAddressLabel(const id: WideString; out type_: Integer; out caption: WideString; 
                             out address: WideString; out locality: WideString; 
                             out adminDistrict: WideString; out postalCode: WideString; 
                             out country: WideString; out information: WideString; 
                             out latitude: Double; out longitude: Double; out confidence: WideString): Integer; safecall;
    procedure Initialize(const settingsRegistryPath: WideString; const applicationURL: WideString; 
                         const applicationId: WideString; const country: WideString; 
                         const mapState: WideString; mapWidth: Integer; mapHeight: Integer); safecall;
    procedure Show; safecall;
    function ShowDialog: Integer; safecall;
    procedure Close; safecall;
  end;

// *********************************************************************//
// DispIntf:  ILocationMapServiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}
// *********************************************************************//
  ILocationMapServiceDisp = dispinterface
    ['{7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}']
    procedure AddAddressLabel(const id: WideString; type_: Integer; const caption: WideString; 
                              const address: WideString; const locality: WideString; 
                              const adminDistrict: WideString; const postalCode: WideString; 
                              const country: WideString; const information: WideString; 
                              latitude: Double; longitude: Double; const confidence: WideString; 
                              bitmap: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 1;
    function GetAddressLabel(const id: WideString; out type_: Integer; out caption: WideString; 
                             out address: WideString; out locality: WideString; 
                             out adminDistrict: WideString; out postalCode: WideString; 
                             out country: WideString; out information: WideString; 
                             out latitude: Double; out longitude: Double; out confidence: WideString): Integer; dispid 2;
    procedure Initialize(const settingsRegistryPath: WideString; const applicationURL: WideString; 
                         const applicationId: WideString; const country: WideString; 
                         const mapState: WideString; mapWidth: Integer; mapHeight: Integer); dispid 3;
    procedure Show; dispid 4;
    function ShowDialog: Integer; dispid 5;
    procedure Close; dispid 6;
  end;

// *********************************************************************//
// Interface: ILocationMapServiceEvents
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F03C34F5-CDD3-4558-8895-1A81C535CD8F}
// *********************************************************************//
  ILocationMapServiceEvents = interface(IDispatch)
    ['{F03C34F5-CDD3-4558-8895-1A81C535CD8F}']
    procedure OnFormClosed; safecall;
    procedure OnMapCaptured(const mapState: WideString; mapImage: PSafeArray); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILocationMapServiceEventsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F03C34F5-CDD3-4558-8895-1A81C535CD8F}
// *********************************************************************//
  ILocationMapServiceEventsDisp = dispinterface
    ['{F03C34F5-CDD3-4558-8895-1A81C535CD8F}']
    procedure OnFormClosed; dispid 1;
    procedure OnMapCaptured(const mapState: WideString; 
                            mapImage: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 2;
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

  TLocationMapServiceOnMapCaptured = procedure(ASender: TObject; const mapState: WideString; 
                                                                 mapImage: PSafeArray) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TLocationMapService
// Help String      : COM automation class for the location map service.
// Default Interface: ILocationMapService
// Def. Intf. DISP? : No
// Event   Interface: ILocationMapServiceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TLocationMapService = class(TOleServer)
  private
    FOnFormClosed: TNotifyEvent;
    FOnMapCaptured: TLocationMapServiceOnMapCaptured;
    FIntf: ILocationMapService;
    function GetDefaultInterface: ILocationMapService;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ILocationMapService);
    procedure Disconnect; override;
    procedure AddAddressLabel(const id: WideString; type_: Integer; const caption: WideString; 
                              const address: WideString; const locality: WideString; 
                              const adminDistrict: WideString; const postalCode: WideString; 
                              const country: WideString; const information: WideString; 
                              latitude: Double; longitude: Double; const confidence: WideString; 
                              bitmap: PSafeArray);
    function GetAddressLabel(const id: WideString; out type_: Integer; out caption: WideString; 
                             out address: WideString; out locality: WideString; 
                             out adminDistrict: WideString; out postalCode: WideString; 
                             out country: WideString; out information: WideString; 
                             out latitude: Double; out longitude: Double; out confidence: WideString): Integer;
    procedure Initialize(const settingsRegistryPath: WideString; const applicationURL: WideString; 
                         const applicationId: WideString; const country: WideString; 
                         const mapState: WideString; mapWidth: Integer; mapHeight: Integer);
    procedure Show;
    function ShowDialog: Integer;
    procedure Close;
    property DefaultInterface: ILocationMapService read GetDefaultInterface;
  published
    property OnFormClosed: TNotifyEvent read FOnFormClosed write FOnFormClosed;
    property OnMapCaptured: TLocationMapServiceOnMapCaptured read FOnMapCaptured write FOnMapCaptured;
  end;

// *********************************************************************//
// The Class CoMapCapturedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _MapCapturedEventHandler exposed by              
// the CoClass MapCapturedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMapCapturedEventHandler = class
    class function Create: _MapCapturedEventHandler;
    class function CreateRemote(const MachineName: string): _MapCapturedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMapCapturedEventHandler
// Help String      : Represents the method that handles a MapCaptured event.
// Default Interface: _MapCapturedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TMapCapturedEventHandler = class(TOleServer)
  private
    FIntf: _MapCapturedEventHandler;
    function GetDefaultInterface: _MapCapturedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MapCapturedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _MapCapturedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoMapFormClosedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _MapFormClosedEventHandler exposed by              
// the CoClass MapFormClosedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMapFormClosedEventHandler = class
    class function Create: _MapFormClosedEventHandler;
    class function CreateRemote(const MachineName: string): _MapFormClosedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMapFormClosedEventHandler
// Help String      : Represents the method that handles a MapFormClosed event.
// Default Interface: _MapFormClosedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TMapFormClosedEventHandler = class(TOleServer)
  private
    FIntf: _MapFormClosedEventHandler;
    function GetDefaultInterface: _MapFormClosedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MapFormClosedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _MapFormClosedEventHandler read GetDefaultInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = '(none)';

  dtlOcxPage = '(none)';

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

procedure TLocationMapService.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{33CC5481-1B8E-49CF-A109-BD3B414ED540}';
    IntfIID:   '{7759F3DE-5FDB-4544-ACD8-CCD2E5348A6A}';
    EventIID:  '{F03C34F5-CDD3-4558-8895-1A81C535CD8F}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TLocationMapService.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ILocationMapService;
  end;
end;

procedure TLocationMapService.ConnectTo(svrIntf: ILocationMapService);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TLocationMapService.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TLocationMapService.GetDefaultInterface: ILocationMapService;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TLocationMapService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TLocationMapService.Destroy;
begin
  inherited Destroy;
end;

procedure TLocationMapService.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  psa: PSafeArray;
begin
  psa := nil;
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnFormClosed) then
         FOnFormClosed(Self);
    2: if Assigned(FOnMapCaptured) then
         FOnMapCaptured(Self,
                        Params[0] {const WideString},
                        //Params[1] { NOT_OLEAUTO(PSafeArray) OleVariant});
                        psa);
  end; {case DispID}
end;

procedure TLocationMapService.AddAddressLabel(const id: WideString; type_: Integer; 
                                              const caption: WideString; const address: WideString; 
                                              const locality: WideString; 
                                              const adminDistrict: WideString; 
                                              const postalCode: WideString; 
                                              const country: WideString; 
                                              const information: WideString; latitude: Double; 
                                              longitude: Double; const confidence: WideString; 
                                              bitmap: PSafeArray);
begin
  DefaultInterface.AddAddressLabel(id, type_, caption, address, locality, adminDistrict, 
                                   postalCode, country, information, latitude, longitude, 
                                   confidence, bitmap);
end;

function TLocationMapService.GetAddressLabel(const id: WideString; out type_: Integer; 
                                             out caption: WideString; out address: WideString; 
                                             out locality: WideString; 
                                             out adminDistrict: WideString; 
                                             out postalCode: WideString; out country: WideString; 
                                             out information: WideString; out latitude: Double; 
                                             out longitude: Double; out confidence: WideString): Integer;
begin
  Result := DefaultInterface.GetAddressLabel(id, type_, caption, address, locality, adminDistrict, 
                                             postalCode, country, information, latitude, longitude, 
                                             confidence);
end;

procedure TLocationMapService.Initialize(const settingsRegistryPath: WideString; 
                                         const applicationURL: WideString; 
                                         const applicationId: WideString; 
                                         const country: WideString; const mapState: WideString; 
                                         mapWidth: Integer; mapHeight: Integer);
begin
  DefaultInterface.Initialize(settingsRegistryPath, applicationURL, applicationId, country, 
                              mapState, mapWidth, mapHeight);
end;

procedure TLocationMapService.Show;
begin
  DefaultInterface.Show;
end;

function TLocationMapService.ShowDialog: Integer;
begin
  Result := DefaultInterface.ShowDialog;
end;

procedure TLocationMapService.Close;
begin
  DefaultInterface.Close;
end;

class function CoMapCapturedEventHandler.Create: _MapCapturedEventHandler;
begin
  Result := CreateComObject(CLASS_MapCapturedEventHandler) as _MapCapturedEventHandler;
end;

class function CoMapCapturedEventHandler.CreateRemote(const MachineName: string): _MapCapturedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MapCapturedEventHandler) as _MapCapturedEventHandler;
end;

procedure TMapCapturedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8947771E-4BC3-3F97-8B5C-D7D5E681EA06}';
    IntfIID:   '{FD13A46C-78F4-3EC6-8601-DF64C376FB66}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMapCapturedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MapCapturedEventHandler;
  end;
end;

procedure TMapCapturedEventHandler.ConnectTo(svrIntf: _MapCapturedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMapCapturedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMapCapturedEventHandler.GetDefaultInterface: _MapCapturedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMapCapturedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TMapCapturedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoMapFormClosedEventHandler.Create: _MapFormClosedEventHandler;
begin
  Result := CreateComObject(CLASS_MapFormClosedEventHandler) as _MapFormClosedEventHandler;
end;

class function CoMapFormClosedEventHandler.CreateRemote(const MachineName: string): _MapFormClosedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MapFormClosedEventHandler) as _MapFormClosedEventHandler;
end;

procedure TMapFormClosedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{82324714-FCFA-31AF-A3F5-411AC16B8A39}';
    IntfIID:   '{BC5CE198-9228-3286-9677-EB78C793CBB2}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMapFormClosedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MapFormClosedEventHandler;
  end;
end;

procedure TMapFormClosedEventHandler.ConnectTo(svrIntf: _MapFormClosedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMapFormClosedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMapFormClosedEventHandler.GetDefaultInterface: _MapFormClosedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMapFormClosedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TMapFormClosedEventHandler.Destroy;
begin
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TLocationMapService, TMapCapturedEventHandler, TMapFormClosedEventHandler]);
end;

end.
