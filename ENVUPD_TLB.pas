unit ENVUPD_TLB;

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
// File generated on 12/8/2011 3:00:13 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Bradford\ClickForms\AppraisalWorld\AIReady\FNC Uploader\envupd.exe (1)
// LIBID: {84493AA1-988D-11D4-BBE5-00105A1F5BF6}
// LCID: 0
// Helpfile: 
// HelpString: ENVUPD Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
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
  ENVUPDMajorVersion = 1;
  ENVUPDMinorVersion = 0;

  LIBID_ENVUPD: TGUID = '{84493AA1-988D-11D4-BBE5-00105A1F5BF6}';

  IID_IPackage: TGUID = '{84493AA2-988D-11D4-BBE5-00105A1F5BF6}';
  CLASS_Package: TGUID = '{84493AA4-988D-11D4-BBE5-00105A1F5BF6}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPackage = interface;
  IPackageDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Package = IPackage;


// *********************************************************************//
// Interface: IPackage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {84493AA2-988D-11D4-BBE5-00105A1F5BF6}
// *********************************************************************//
  IPackage = interface(IDispatch)
    ['{84493AA2-988D-11D4-BBE5-00105A1F5BF6}']
    function AddFile(const FileName: WideString; const Description: WideString; 
                     const Params: WideString): WordBool; safecall;
    function Pack(const FileName: WideString; const Params: WideString): WordBool; safecall;
    function SendHttp(const URL: WideString; const IdToURL: WideString; const PasToURL: WideString; 
                      const Proxy: WideString; const IdToProxy: WideString; 
                      const PasToProxy: WideString; const EnvelopeFile: WideString; 
                      out ServerReply: WideString): WordBool; safecall;
    procedure ClearFiles; safecall;
    function Upload(const Destination: WideString; const EnvelopeFile: WideString; 
                    const Port_id: WideString; const Folder: WideString; Fee: Double): WideString; safecall;
    function Filter(const SourceXML: WideString; const FilterName: WideString; 
                    out MapResult: WideString): WordBool; safecall;
    procedure HideMainForm; safecall;
    procedure ShowMainForm; safecall;
    function EditFilter(const FilterName: WideString): WordBool; safecall;
    procedure HideOnClose; safecall;
    function AddMainForm(const FileName: WideString; const Description: WideString): WideString; safecall;
    function AddImage(const FileName: WideString; const Description: WideString; 
                      const Key: WideString): WideString; safecall;
    function AddAddendumForm(const FileName: WideString; const Description: WideString): WideString; safecall;
    procedure HideSend; safecall;
    procedure ShowSend; safecall;
  end;

// *********************************************************************//
// DispIntf:  IPackageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {84493AA2-988D-11D4-BBE5-00105A1F5BF6}
// *********************************************************************//
  IPackageDisp = dispinterface
    ['{84493AA2-988D-11D4-BBE5-00105A1F5BF6}']
    function AddFile(const FileName: WideString; const Description: WideString; 
                     const Params: WideString): WordBool; dispid 1;
    function Pack(const FileName: WideString; const Params: WideString): WordBool; dispid 2;
    function SendHttp(const URL: WideString; const IdToURL: WideString; const PasToURL: WideString; 
                      const Proxy: WideString; const IdToProxy: WideString; 
                      const PasToProxy: WideString; const EnvelopeFile: WideString; 
                      out ServerReply: WideString): WordBool; dispid 3;
    procedure ClearFiles; dispid 4;
    function Upload(const Destination: WideString; const EnvelopeFile: WideString; 
                    const Port_id: WideString; const Folder: WideString; Fee: Double): WideString; dispid 5;
    function Filter(const SourceXML: WideString; const FilterName: WideString; 
                    out MapResult: WideString): WordBool; dispid 6;
    procedure HideMainForm; dispid 7;
    procedure ShowMainForm; dispid 8;
    function EditFilter(const FilterName: WideString): WordBool; dispid 9;
    procedure HideOnClose; dispid 10;
    function AddMainForm(const FileName: WideString; const Description: WideString): WideString; dispid 11;
    function AddImage(const FileName: WideString; const Description: WideString; 
                      const Key: WideString): WideString; dispid 12;
    function AddAddendumForm(const FileName: WideString; const Description: WideString): WideString; dispid 13;
    procedure HideSend; dispid 14;
    procedure ShowSend; dispid 15;
  end;

// *********************************************************************//
// The Class CoPackage provides a Create and CreateRemote method to          
// create instances of the default interface IPackage exposed by              
// the CoClass Package. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPackage = class
    class function Create: IPackage;
    class function CreateRemote(const MachineName: string): IPackage;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPackage
// Help String      : Package Object
// Default Interface: IPackage
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPackageProperties= class;
{$ENDIF}
  TPackage = class(TOleServer)
  private
    FIntf:        IPackage;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPackageProperties;
    function      GetServerProperties: TPackageProperties;
{$ENDIF}
    function      GetDefaultInterface: IPackage;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IPackage);
    procedure Disconnect; override;
    function AddFile(const FileName: WideString; const Description: WideString; 
                     const Params: WideString): WordBool;
    function Pack(const FileName: WideString; const Params: WideString): WordBool;
    function SendHttp(const URL: WideString; const IdToURL: WideString; const PasToURL: WideString; 
                      const Proxy: WideString; const IdToProxy: WideString; 
                      const PasToProxy: WideString; const EnvelopeFile: WideString; 
                      out ServerReply: WideString): WordBool;
    procedure ClearFiles;
    function Upload(const Destination: WideString; const EnvelopeFile: WideString; 
                    const Port_id: WideString; const Folder: WideString; Fee: Double): WideString;
    function Filter(const SourceXML: WideString; const FilterName: WideString; 
                    out MapResult: WideString): WordBool;
    procedure HideMainForm;
    procedure ShowMainForm;
    function EditFilter(const FilterName: WideString): WordBool;
    procedure HideOnClose;
    function AddMainForm(const FileName: WideString; const Description: WideString): WideString;
    function AddImage(const FileName: WideString; const Description: WideString; 
                      const Key: WideString): WideString;
    function AddAddendumForm(const FileName: WideString; const Description: WideString): WideString;
    procedure HideSend;
    procedure ShowSend;
    property DefaultInterface: IPackage read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPackageProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPackage
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPackageProperties = class(TPersistent)
  private
    FServer:    TPackage;
    function    GetDefaultInterface: IPackage;
    constructor Create(AServer: TPackage);
  protected
  public
    property DefaultInterface: IPackage read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoPackage.Create: IPackage;
begin
  Result := CreateComObject(CLASS_Package) as IPackage;
end;

class function CoPackage.CreateRemote(const MachineName: string): IPackage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Package) as IPackage;
end;

procedure TPackage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{84493AA4-988D-11D4-BBE5-00105A1F5BF6}';
    IntfIID:   '{84493AA2-988D-11D4-BBE5-00105A1F5BF6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPackage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IPackage;
  end;
end;

procedure TPackage.ConnectTo(svrIntf: IPackage);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPackage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPackage.GetDefaultInterface: IPackage;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPackage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPackageProperties.Create(Self);
{$ENDIF}
end;

destructor TPackage.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPackage.GetServerProperties: TPackageProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TPackage.AddFile(const FileName: WideString; const Description: WideString; 
                          const Params: WideString): WordBool;
begin
  Result := DefaultInterface.AddFile(FileName, Description, Params);
end;

function TPackage.Pack(const FileName: WideString; const Params: WideString): WordBool;
begin
  Result := DefaultInterface.Pack(FileName, Params);
end;

function TPackage.SendHttp(const URL: WideString; const IdToURL: WideString; 
                           const PasToURL: WideString; const Proxy: WideString; 
                           const IdToProxy: WideString; const PasToProxy: WideString; 
                           const EnvelopeFile: WideString; out ServerReply: WideString): WordBool;
begin
  Result := DefaultInterface.SendHttp(URL, IdToURL, PasToURL, Proxy, IdToProxy, PasToProxy, 
                                      EnvelopeFile, ServerReply);
end;

procedure TPackage.ClearFiles;
begin
  DefaultInterface.ClearFiles;
end;

function TPackage.Upload(const Destination: WideString; const EnvelopeFile: WideString; 
                         const Port_id: WideString; const Folder: WideString; Fee: Double): WideString;
begin
  Result := DefaultInterface.Upload(Destination, EnvelopeFile, Port_id, Folder, Fee);
end;

function TPackage.Filter(const SourceXML: WideString; const FilterName: WideString; 
                         out MapResult: WideString): WordBool;
begin
  Result := DefaultInterface.Filter(SourceXML, FilterName, MapResult);
end;

procedure TPackage.HideMainForm;
begin
  DefaultInterface.HideMainForm;
end;

procedure TPackage.ShowMainForm;
begin
  DefaultInterface.ShowMainForm;
end;

function TPackage.EditFilter(const FilterName: WideString): WordBool;
begin
  Result := DefaultInterface.EditFilter(FilterName);
end;

procedure TPackage.HideOnClose;
begin
  DefaultInterface.HideOnClose;
end;

function TPackage.AddMainForm(const FileName: WideString; const Description: WideString): WideString;
begin
  Result := DefaultInterface.AddMainForm(FileName, Description);
end;

function TPackage.AddImage(const FileName: WideString; const Description: WideString; 
                           const Key: WideString): WideString;
begin
  Result := DefaultInterface.AddImage(FileName, Description, Key);
end;

function TPackage.AddAddendumForm(const FileName: WideString; const Description: WideString): WideString;
begin
  Result := DefaultInterface.AddAddendumForm(FileName, Description);
end;

procedure TPackage.HideSend;
begin
  DefaultInterface.HideSend;
end;

procedure TPackage.ShowSend;
begin
  DefaultInterface.ShowSend;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPackageProperties.Create(AServer: TPackage);
begin
  inherited Create;
  FServer := AServer;
end;

function TPackageProperties.GetDefaultInterface: IPackage;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TPackage]);
end;

end.
