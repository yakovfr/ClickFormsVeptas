// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx?WSDL
//  >Import : http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (08/18/2011 12:46:58 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit AMC_Valulink_TLB;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]


  ArrayOfString = array of WideString;          { "http://www.vlusers.com/"[GblCplx] }

  // ************************************************************************ //
  // Namespace : http://www.vlusers.com/
  // soapAction: http://www.vlusers.com/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : AppraisalServiceSoap
  // service   : AppraisalService
  // port      : AppraisalServiceSoap
  // URL       : http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx
  // ************************************************************************ //
  AppraisalServiceSoap = interface(IInvokable)
  ['{2D1D763D-5A1F-CA20-6744-FCDCCD47CDBF}']
    function  PostAppraisalFiles(const Username: WideString; const Password: WideString; const ValuLinkClient: WideString; const AppraisalXml: WideString): WideString; stdcall;
    function  GetValuLinkClients: ArrayOfString; stdcall;
  end;

function GetValulinkServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AppraisalServiceSoap;


implementation
  uses SysUtils;

function GetValulinkServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AppraisalServiceSoap;
const
  defWSDL = 'http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx?WSDL';
  defURL  = 'http://w3.collabrian.net/ClickFormsWS/Appraisal.asmx';
  defSvc  = 'AppraisalService';
  defPrt  = 'AppraisalServiceSoap';
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
    Result := (RIO as AppraisalServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(AppraisalServiceSoap), 'http://www.vlusers.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AppraisalServiceSoap), 'http://www.vlusers.com/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AppraisalServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://www.vlusers.com/', 'ArrayOfString');

end.