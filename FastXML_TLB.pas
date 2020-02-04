unit FastXML_TLB;

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
// File generated on 1/20/2004 2:23:16 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms\AiReady\fast XML\FastXML.dll (1)
// LIBID: {BC89E0D2-9DDC-11D3-BB70-00105A1F5BF6}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
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
  FastXMLMajorVersion = 1;
  FastXMLMinorVersion = 0;

  LIBID_FastXML: TGUID = '{BC89E0D2-9DDC-11D3-BB70-00105A1F5BF6}';

  IID_IXMLDOM: TGUID = '{BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}';
  CLASS_XMLDOM: TGUID = '{BC89E0D5-9DDC-11D3-BB70-00105A1F5BF6}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IXMLDOM = interface;
  IXMLDOMDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  XMLDOM = IXMLDOM;


// *********************************************************************//
// Interface: IXMLDOM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}
// *********************************************************************//
  IXMLDOM = interface(IDispatch)
    ['{BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}']
    function LoadXML(Source: OleVariant): OleVariant; safecall;
    function ReadNode(Path: OleVariant): OleVariant; safecall;
    procedure NewXML(Tag: OleVariant); safecall;
    function XML: OleVariant; safecall;
    function WriteNode(Path: OleVariant; ValueSource: OleVariant): OleVariant; safecall;
    function Get_Document: IDispatch; safecall;
    function Write(const node: IDispatch; const Path: WideString; const Attrib: WideString; 
                   const Value: WideString): OleVariant; safecall;
    function GetNode(const Parent: IDispatch; Path: OleVariant; var rnode: OleVariant): OleVariant; safecall;
    function GetNodeX(const Parent: IDispatch; Path: OleVariant): IDispatch; safecall;
    function RootElement: IDispatch; safecall;
    function ReadValue(const node: IDispatch; const Path: WideString): OleVariant; safecall;
    function WriteValue(const node: IDispatch; const Path: WideString; Text: OleVariant): OleVariant; safecall;
    function Read(const node: IDispatch; const Path: WideString; const Attrib: WideString): OleVariant; safecall;
    function LoadAliases(const FileName: WideString): OleVariant; safecall;
    function WriteAlias(const Aliase: WideString; Value: OleVariant): WordBool; safecall;
    function ReadAlias(const Aliase: WideString; out Code: WordBool): WideString; safecall;
    property Document: IDispatch read Get_Document;
  end;

// *********************************************************************//
// DispIntf:  IXMLDOMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}
// *********************************************************************//
  IXMLDOMDisp = dispinterface
    ['{BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}']
    function LoadXML(Source: OleVariant): OleVariant; dispid 1;
    function ReadNode(Path: OleVariant): OleVariant; dispid 5;
    procedure NewXML(Tag: OleVariant); dispid 3;
    function XML: OleVariant; dispid 4;
    function WriteNode(Path: OleVariant; ValueSource: OleVariant): OleVariant; dispid 6;
    property Document: IDispatch readonly dispid 2;
    function Write(const node: IDispatch; const Path: WideString; const Attrib: WideString; 
                   const Value: WideString): OleVariant; dispid 7;
    function GetNode(const Parent: IDispatch; Path: OleVariant; var rnode: OleVariant): OleVariant; dispid 8;
    function GetNodeX(const Parent: IDispatch; Path: OleVariant): IDispatch; dispid 9;
    function RootElement: IDispatch; dispid 10;
    function ReadValue(const node: IDispatch; const Path: WideString): OleVariant; dispid 12;
    function WriteValue(const node: IDispatch; const Path: WideString; Text: OleVariant): OleVariant; dispid 13;
    function Read(const node: IDispatch; const Path: WideString; const Attrib: WideString): OleVariant; dispid 14;
    function LoadAliases(const FileName: WideString): OleVariant; dispid 11;
    function WriteAlias(const Aliase: WideString; Value: OleVariant): WordBool; dispid 15;
    function ReadAlias(const Aliase: WideString; out Code: WordBool): WideString; dispid 16;
  end;

// *********************************************************************//
// The Class CoXMLDOM provides a Create and CreateRemote method to          
// create instances of the default interface IXMLDOM exposed by              
// the CoClass XMLDOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXMLDOM = class
    class function Create: IXMLDOM;
    class function CreateRemote(const MachineName: string): IXMLDOM;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TXMLDOM
// Help String      : XMLDOM Object
// Default Interface: IXMLDOM
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXMLDOMProperties= class;
{$ENDIF}
  TXMLDOM = class(TOleServer)
  private
    FIntf:        IXMLDOM;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TXMLDOMProperties;
    function      GetServerProperties: TXMLDOMProperties;
{$ENDIF}
    function      GetDefaultInterface: IXMLDOM;
  protected
    procedure InitServerData; override;
    function Get_Document: IDispatch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOM);
    procedure Disconnect; override;
    function LoadXML(Source: OleVariant): OleVariant;
    function ReadNode(Path: OleVariant): OleVariant;
    procedure NewXML(Tag: OleVariant);
    function XML: OleVariant;
    function WriteNode(Path: OleVariant; ValueSource: OleVariant): OleVariant;
    function Write(const node: IDispatch; const Path: WideString; const Attrib: WideString; 
                   const Value: WideString): OleVariant;
    function GetNode(const Parent: IDispatch; Path: OleVariant; var rnode: OleVariant): OleVariant;
    function GetNodeX(const Parent: IDispatch; Path: OleVariant): IDispatch;
    function RootElement: IDispatch;
    function ReadValue(const node: IDispatch; const Path: WideString): OleVariant;
    function WriteValue(const node: IDispatch; const Path: WideString; Text: OleVariant): OleVariant;
    function Read(const node: IDispatch; const Path: WideString; const Attrib: WideString): OleVariant;
    function LoadAliases(const FileName: WideString): OleVariant;
    function WriteAlias(const Aliase: WideString; Value: OleVariant): WordBool;
    function ReadAlias(const Aliase: WideString; out Code: WordBool): WideString;
    property DefaultInterface: IXMLDOM read GetDefaultInterface;
    property Document: IDispatch read Get_Document;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXMLDOMProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TXMLDOM
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TXMLDOMProperties = class(TPersistent)
  private
    FServer:    TXMLDOM;
    function    GetDefaultInterface: IXMLDOM;
    constructor Create(AServer: TXMLDOM);
  protected
    function Get_Document: IDispatch;
  public
    property DefaultInterface: IXMLDOM read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoXMLDOM.Create: IXMLDOM;
begin
  Result := CreateComObject(CLASS_XMLDOM) as IXMLDOM;
end;

class function CoXMLDOM.CreateRemote(const MachineName: string): IXMLDOM;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XMLDOM) as IXMLDOM;
end;

procedure TXMLDOM.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BC89E0D5-9DDC-11D3-BB70-00105A1F5BF6}';
    IntfIID:   '{BC89E0D3-9DDC-11D3-BB70-00105A1F5BF6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXMLDOM.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOM;
  end;
end;

procedure TXMLDOM.ConnectTo(svrIntf: IXMLDOM);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXMLDOM.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXMLDOM.GetDefaultInterface: IXMLDOM;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TXMLDOM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXMLDOMProperties.Create(Self);
{$ENDIF}
end;

destructor TXMLDOM.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXMLDOM.GetServerProperties: TXMLDOMProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TXMLDOM.Get_Document: IDispatch;
begin
    Result := DefaultInterface.Document;
end;

function TXMLDOM.LoadXML(Source: OleVariant): OleVariant;
begin
  Result := DefaultInterface.LoadXML(Source);
end;

function TXMLDOM.ReadNode(Path: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ReadNode(Path);
end;

procedure TXMLDOM.NewXML(Tag: OleVariant);
begin
  DefaultInterface.NewXML(Tag);
end;

function TXMLDOM.XML: OleVariant;
begin
  Result := DefaultInterface.XML;
end;

function TXMLDOM.WriteNode(Path: OleVariant; ValueSource: OleVariant): OleVariant;
begin
  Result := DefaultInterface.WriteNode(Path, ValueSource);
end;

function TXMLDOM.Write(const node: IDispatch; const Path: WideString; const Attrib: WideString; 
                       const Value: WideString): OleVariant;
begin
  Result := DefaultInterface.Write(node, Path, Attrib, Value);
end;

function TXMLDOM.GetNode(const Parent: IDispatch; Path: OleVariant; var rnode: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNode(Parent, Path, rnode);
end;

function TXMLDOM.GetNodeX(const Parent: IDispatch; Path: OleVariant): IDispatch;
begin
  Result := DefaultInterface.GetNodeX(Parent, Path);
end;

function TXMLDOM.RootElement: IDispatch;
begin
  Result := DefaultInterface.RootElement;
end;

function TXMLDOM.ReadValue(const node: IDispatch; const Path: WideString): OleVariant;
begin
  Result := DefaultInterface.ReadValue(node, Path);
end;

function TXMLDOM.WriteValue(const node: IDispatch; const Path: WideString; Text: OleVariant): OleVariant;
begin
  Result := DefaultInterface.WriteValue(node, Path, Text);
end;

function TXMLDOM.Read(const node: IDispatch; const Path: WideString; const Attrib: WideString): OleVariant;
begin
  Result := DefaultInterface.Read(node, Path, Attrib);
end;

function TXMLDOM.LoadAliases(const FileName: WideString): OleVariant;
begin
  Result := DefaultInterface.LoadAliases(FileName);
end;

function TXMLDOM.WriteAlias(const Aliase: WideString; Value: OleVariant): WordBool;
begin
  Result := DefaultInterface.WriteAlias(Aliase, Value);
end;

function TXMLDOM.ReadAlias(const Aliase: WideString; out Code: WordBool): WideString;
begin
  Result := DefaultInterface.ReadAlias(Aliase, Code);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXMLDOMProperties.Create(AServer: TXMLDOM);
begin
  inherited Create;
  FServer := AServer;
end;

function TXMLDOMProperties.GetDefaultInterface: IXMLDOM;
begin
  Result := FServer.DefaultInterface;
end;

function TXMLDOMProperties.Get_Document: IDispatch;
begin
    Result := DefaultInterface.Document;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TXMLDOM]);
end;

end.
