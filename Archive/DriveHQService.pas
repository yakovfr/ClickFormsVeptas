// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WSDriveHQ/DriveHQService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (8/18/2006 11:34:59 AM - 1.33.2.5)
// ************************************************************************ //

unit DriveHQService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/CanCusotmerUseDriveHQ
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : DriveHQServiceSoap
  // service   : DriveHQService
  // port      : DriveHQServiceSoap
  // URL       : http://localhost/WSDriveHQ/DriveHQService.asmx
  // ************************************************************************ //
  DriveHQServiceSoap = interface(IInvokable)
  ['{D89A975A-CAAB-016E-EAD0-455E678B59C7}']
    procedure CanCusotmerUseDriveHQ(const iCustID: Integer; const sKey: WideString; out CanCusotmerUseDriveHQResult: WideString; out iMsgCode: Integer); stdcall;
  end;

function GetDriveHQServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): DriveHQServiceSoap;


implementation

function GetDriveHQServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): DriveHQServiceSoap;
const
  defWSDL = 'http://localhost/WSDriveHQ/DriveHQService.asmx?wsdl';
  defURL  = 'http://localhost/WSDriveHQ/DriveHQService.asmx';
  defSvc  = 'DriveHQService';
  defPrt  = 'DriveHQServiceSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as DriveHQServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(DriveHQServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(DriveHQServiceSoap), 'http://tempuri.org/CanCusotmerUseDriveHQ');
  InvRegistry.RegisterInvokeOptions(TypeInfo(DriveHQServiceSoap), ioDocument);

end. 