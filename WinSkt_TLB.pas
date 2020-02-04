unit WinSkt_TLB;

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
// File generated on 1/28/2004 8:01:33 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickformComponents6\WinSketch751\WinSkt.tlb (1)
// LIBID: {A03AB197-97CF-4D1D-925C-F0D46671CC38}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\SYSTEM32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// Errors:
//   Hint: TypeInfo 'WinSkt' changed to 'WinSkt_'
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
  WinSktMajorVersion = 1;
  WinSktMinorVersion = 0;

  LIBID_WinSkt: TGUID = '{A03AB197-97CF-4D1D-925C-F0D46671CC38}';

  DIID_IWinSktEvents: TGUID = '{9A4417B9-E6EB-474E-96AB-C2EB11618047}';
  DIID_IWinSkt: TGUID = '{D48F751E-713C-4366-89A1-1212C94048A4}';
  CLASS_WinSkt_: TGUID = '{BC8D643B-19E6-467C-AEB3-9645D25F4370}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWinSktEvents = dispinterface;
  IWinSkt = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  WinSkt_ = IWinSkt;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}


// *********************************************************************//
// DispIntf:  IWinSktEvents
// Flags:     (4096) Dispatchable
// GUID:      {9A4417B9-E6EB-474E-96AB-C2EB11618047}
// *********************************************************************//
  IWinSktEvents = dispinterface
    ['{9A4417B9-E6EB-474E-96AB-C2EB11618047}']
    procedure UpdateImage(pageno: Smallint); dispid 1;
    procedure UpdateCalculations(var pCalc: OleVariant); dispid 2;
    procedure UpdateCalculations2(var pCalc: OleVariant); dispid 4;
    procedure SketchClosed; dispid 5;
    procedure UpdateCalculationSummary(var pCalc: OleVariant); dispid 6;
  end;

// *********************************************************************//
// DispIntf:  IWinSkt
// Flags:     (4096) Dispatchable
// GUID:      {D48F751E-713C-4366-89A1-1212C94048A4}
// *********************************************************************//
  IWinSkt = dispinterface
    ['{D48F751E-713C-4366-89A1-1212C94048A4}']
    property FileNo: WideString dispid 1;
    property Borrower: WideString dispid 2;
    property PropertyAddress: WideString dispid 3;
    property City: WideString dispid 4;
    property County: WideString dispid 5;
    property State: WideString dispid 6;
    property ZipCode: WideString dispid 7;
    property Client: WideString dispid 8;
    property ClientAddress: WideString dispid 9;
    function OpenSketch(const fileName: WideString): WordBool; dispid 10;
    function GetCalculations(out calcs: OleVariant): WordBool; dispid 11;
    function GetImage(pageno: Smallint): WordBool; dispid 12;
    function GetCalculations2(out calcs: OleVariant): WordBool; dispid 13;
    function SaveSketch(const fileName: WideString; calcPageNo: Smallint): WordBool; dispid 14;
    function OpenAreaCalcSketch(const fileName: WideString; backup: Integer): WordBool; dispid 15;
    function GetFileName: WideString; dispid 16;
    function GetCalculationSummary(out calcs: OleVariant): WordBool; dispid 17;
  end;

// *********************************************************************//
// The Class CoWinSkt_ provides a Create and CreateRemote method to          
// create instances of the default interface IWinSkt exposed by              
// the CoClass WinSkt_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWinSkt_ = class
    class function Create: IWinSkt;
    class function CreateRemote(const MachineName: string): IWinSkt;
  end;

  TWinSktUpdateImage = procedure(Sender: TObject; pageno: Smallint) of object;
  TWinSktUpdateCalculations = procedure(Sender: TObject; var pCalc: OleVariant) of object;
  TWinSktUpdateCalculations2 = procedure(Sender: TObject; var pCalc: OleVariant) of object;
  TWinSktUpdateCalculationSummary = procedure(Sender: TObject; var pCalc: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TWinSkt
// Help String      : 
// Default Interface: IWinSkt
// Def. Intf. DISP? : Yes
// Event   Interface: IWinSktEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TWinSktProperties= class;
{$ENDIF}
  TWinSkt = class(TOleServer)
  private
    FOnUpdateImage: TWinSktUpdateImage;
    FOnUpdateCalculations: TWinSktUpdateCalculations;
    FOnUpdateCalculations2: TWinSktUpdateCalculations2;
    FOnSketchClosed: TNotifyEvent;
    FOnUpdateCalculationSummary: TWinSktUpdateCalculationSummary;
    FIntf:        IWinSkt;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TWinSktProperties;
    function      GetServerProperties: TWinSktProperties;
{$ENDIF}
    function      GetDefaultInterface: IWinSkt;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_FileNo: WideString;
    procedure Set_FileNo(const Value: WideString);
    function Get_Borrower: WideString;
    procedure Set_Borrower(const Value: WideString);
    function Get_PropertyAddress: WideString;
    procedure Set_PropertyAddress(const Value: WideString);
    function Get_City: WideString;
    procedure Set_City(const Value: WideString);
    function Get_County: WideString;
    procedure Set_County(const Value: WideString);
    function Get_State: WideString;
    procedure Set_State(const Value: WideString);
    function Get_ZipCode: WideString;
    procedure Set_ZipCode(const Value: WideString);
    function Get_Client: WideString;
    procedure Set_Client(const Value: WideString);
    function Get_ClientAddress: WideString;
    procedure Set_ClientAddress(const Value: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IWinSkt);
    procedure Disconnect; override;
    function OpenSketch(const fileName: WideString): WordBool;
    function GetCalculations(out calcs: OleVariant): WordBool;
    function GetImage(pageno: Smallint): WordBool;
    function GetCalculations2(out calcs: OleVariant): WordBool;
    function SaveSketch(const fileName: WideString; calcPageNo: Smallint): WordBool;
    function OpenAreaCalcSketch(const fileName: WideString; backup: Integer): WordBool;
    function GetFileName: WideString;
    function GetCalculationSummary(out calcs: OleVariant): WordBool;
    property DefaultInterface: IWinSkt read GetDefaultInterface;
    property FileNo: WideString read Get_FileNo write Set_FileNo;
    property Borrower: WideString read Get_Borrower write Set_Borrower;
    property PropertyAddress: WideString read Get_PropertyAddress write Set_PropertyAddress;
    property City: WideString read Get_City write Set_City;
    property County: WideString read Get_County write Set_County;
    property State: WideString read Get_State write Set_State;
    property ZipCode: WideString read Get_ZipCode write Set_ZipCode;
    property Client: WideString read Get_Client write Set_Client;
    property ClientAddress: WideString read Get_ClientAddress write Set_ClientAddress;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TWinSktProperties read GetServerProperties;
{$ENDIF}
    property OnUpdateImage: TWinSktUpdateImage read FOnUpdateImage write FOnUpdateImage;
    property OnUpdateCalculations: TWinSktUpdateCalculations read FOnUpdateCalculations write FOnUpdateCalculations;
    property OnUpdateCalculations2: TWinSktUpdateCalculations2 read FOnUpdateCalculations2 write FOnUpdateCalculations2;
    property OnSketchClosed: TNotifyEvent read FOnSketchClosed write FOnSketchClosed;
    property OnUpdateCalculationSummary: TWinSktUpdateCalculationSummary read FOnUpdateCalculationSummary write FOnUpdateCalculationSummary;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TWinSkt
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TWinSktProperties = class(TPersistent)
  private
    FServer:    TWinSkt;
    function    GetDefaultInterface: IWinSkt;
    constructor Create(AServer: TWinSkt);
  protected
    function Get_FileNo: WideString;
    procedure Set_FileNo(const Value: WideString);
    function Get_Borrower: WideString;
    procedure Set_Borrower(const Value: WideString);
    function Get_PropertyAddress: WideString;
    procedure Set_PropertyAddress(const Value: WideString);
    function Get_City: WideString;
    procedure Set_City(const Value: WideString);
    function Get_County: WideString;
    procedure Set_County(const Value: WideString);
    function Get_State: WideString;
    procedure Set_State(const Value: WideString);
    function Get_ZipCode: WideString;
    procedure Set_ZipCode(const Value: WideString);
    function Get_Client: WideString;
    procedure Set_Client(const Value: WideString);
    function Get_ClientAddress: WideString;
    procedure Set_ClientAddress(const Value: WideString);
  public
    property DefaultInterface: IWinSkt read GetDefaultInterface;
  published
    property FileNo: WideString read Get_FileNo write Set_FileNo;
    property Borrower: WideString read Get_Borrower write Set_Borrower;
    property PropertyAddress: WideString read Get_PropertyAddress write Set_PropertyAddress;
    property City: WideString read Get_City write Set_City;
    property County: WideString read Get_County write Set_County;
    property State: WideString read Get_State write Set_State;
    property ZipCode: WideString read Get_ZipCode write Set_ZipCode;
    property Client: WideString read Get_Client write Set_Client;
    property ClientAddress: WideString read Get_ClientAddress write Set_ClientAddress;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoWinSkt_.Create: IWinSkt;
begin
  Result := CreateComObject(CLASS_WinSkt_) as IWinSkt;
end;

class function CoWinSkt_.CreateRemote(const MachineName: string): IWinSkt;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WinSkt_) as IWinSkt;
end;

procedure TWinSkt.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BC8D643B-19E6-467C-AEB3-9645D25F4370}';
    IntfIID:   '{D48F751E-713C-4366-89A1-1212C94048A4}';
    EventIID:  '{9A4417B9-E6EB-474E-96AB-C2EB11618047}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TWinSkt.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IWinSkt;
  end;
end;

procedure TWinSkt.ConnectTo(svrIntf: IWinSkt);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TWinSkt.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TWinSkt.GetDefaultInterface: IWinSkt;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TWinSkt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TWinSktProperties.Create(Self);
{$ENDIF}
end;

destructor TWinSkt.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TWinSkt.GetServerProperties: TWinSktProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TWinSkt.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnUpdateImage) then
            FOnUpdateImage(Self, Params[0] {Smallint});
   2: if Assigned(FOnUpdateCalculations) then
            FOnUpdateCalculations(Self, Params[0] {var OleVariant});
   4: if Assigned(FOnUpdateCalculations2) then
            FOnUpdateCalculations2(Self, Params[0] {var OleVariant});
   5: if Assigned(FOnSketchClosed) then
            FOnSketchClosed(Self);
   6: if Assigned(FOnUpdateCalculationSummary) then
            FOnUpdateCalculationSummary(Self, Params[0] {var OleVariant});
  end; {case DispID}
end;

function TWinSkt.Get_FileNo: WideString;
begin
  Result := DefaultInterface.FileNo;
end;

procedure TWinSkt.Set_FileNo(const Value: WideString);
begin
  DefaultInterface.FileNo := Value;
end;

function TWinSkt.Get_Borrower: WideString;
begin
  Result := DefaultInterface.Borrower;
end;

procedure TWinSkt.Set_Borrower(const Value: WideString);
begin
  DefaultInterface.Borrower := Value;
end;

function TWinSkt.Get_PropertyAddress: WideString;
begin
  Result := DefaultInterface.PropertyAddress;
end;

procedure TWinSkt.Set_PropertyAddress(const Value: WideString);
begin
  DefaultInterface.PropertyAddress := Value;
end;

function TWinSkt.Get_City: WideString;
begin
  Result := DefaultInterface.City;
end;

procedure TWinSkt.Set_City(const Value: WideString);
begin
  DefaultInterface.City := Value;
end;

function TWinSkt.Get_County: WideString;
begin
  Result := DefaultInterface.County;
end;

procedure TWinSkt.Set_County(const Value: WideString);
begin
  DefaultInterface.County := Value;
end;

function TWinSkt.Get_State: WideString;
begin
  Result := DefaultInterface.State;
end;

procedure TWinSkt.Set_State(const Value: WideString);
begin
  DefaultInterface.State := Value;
end;

function TWinSkt.Get_ZipCode: WideString;
begin
  Result := DefaultInterface.ZipCode;
end;

procedure TWinSkt.Set_ZipCode(const Value: WideString);
begin
  DefaultInterface.ZipCode := Value;
end;

function TWinSkt.Get_Client: WideString;
begin
  Result := DefaultInterface.Client;
end;

procedure TWinSkt.Set_Client(const Value: WideString);
begin
  DefaultInterface.Client := Value;
end;

function TWinSkt.Get_ClientAddress: WideString;
begin
  Result := DefaultInterface.ClientAddress;
end;

procedure TWinSkt.Set_ClientAddress(const Value: WideString);
begin
  DefaultInterface.ClientAddress := Value;
end;

function TWinSkt.OpenSketch(const fileName: WideString): WordBool;
begin
  Result := DefaultInterface.OpenSketch(fileName);
end;

function TWinSkt.GetCalculations(out calcs: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetCalculations(calcs);
end;

function TWinSkt.GetImage(pageno: Smallint): WordBool;
begin
  Result := DefaultInterface.GetImage(pageno);
end;

function TWinSkt.GetCalculations2(out calcs: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetCalculations2(calcs);
end;

function TWinSkt.SaveSketch(const fileName: WideString; calcPageNo: Smallint): WordBool;
begin
  Result := DefaultInterface.SaveSketch(fileName, calcPageNo);
end;

function TWinSkt.OpenAreaCalcSketch(const fileName: WideString; backup: Integer): WordBool;
begin
  Result := DefaultInterface.OpenAreaCalcSketch(fileName, backup);
end;

function TWinSkt.GetFileName: WideString;
begin
  Result := DefaultInterface.GetFileName;
end;

function TWinSkt.GetCalculationSummary(out calcs: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetCalculationSummary(calcs);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TWinSktProperties.Create(AServer: TWinSkt);
begin
  inherited Create;
  FServer := AServer;
end;

function TWinSktProperties.GetDefaultInterface: IWinSkt;
begin
  Result := FServer.DefaultInterface;
end;

function TWinSktProperties.Get_FileNo: WideString;
begin
  Result := DefaultInterface.FileNo;
end;

procedure TWinSktProperties.Set_FileNo(const Value: WideString);
begin
  DefaultInterface.FileNo := Value;
end;

function TWinSktProperties.Get_Borrower: WideString;
begin
  Result := DefaultInterface.Borrower;
end;

procedure TWinSktProperties.Set_Borrower(const Value: WideString);
begin
  DefaultInterface.Borrower := Value;
end;

function TWinSktProperties.Get_PropertyAddress: WideString;
begin
  Result := DefaultInterface.PropertyAddress;
end;

procedure TWinSktProperties.Set_PropertyAddress(const Value: WideString);
begin
  DefaultInterface.PropertyAddress := Value;
end;

function TWinSktProperties.Get_City: WideString;
begin
  Result := DefaultInterface.City;
end;

procedure TWinSktProperties.Set_City(const Value: WideString);
begin
  DefaultInterface.City := Value;
end;

function TWinSktProperties.Get_County: WideString;
begin
  Result := DefaultInterface.County;
end;

procedure TWinSktProperties.Set_County(const Value: WideString);
begin
  DefaultInterface.County := Value;
end;

function TWinSktProperties.Get_State: WideString;
begin
  Result := DefaultInterface.State;
end;

procedure TWinSktProperties.Set_State(const Value: WideString);
begin
  DefaultInterface.State := Value;
end;

function TWinSktProperties.Get_ZipCode: WideString;
begin
  Result := DefaultInterface.ZipCode;
end;

procedure TWinSktProperties.Set_ZipCode(const Value: WideString);
begin
  DefaultInterface.ZipCode := Value;
end;

function TWinSktProperties.Get_Client: WideString;
begin
  Result := DefaultInterface.Client;
end;

procedure TWinSktProperties.Set_Client(const Value: WideString);
begin
  DefaultInterface.Client := Value;
end;

function TWinSktProperties.Get_ClientAddress: WideString;
begin
  Result := DefaultInterface.ClientAddress;
end;

procedure TWinSktProperties.Set_ClientAddress(const Value: WideString);
begin
  DefaultInterface.ClientAddress := Value;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TWinSkt]);
end;

end.
