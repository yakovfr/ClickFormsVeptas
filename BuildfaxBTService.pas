// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/wsbuildfax/buildfax.asmx?wsdl
//  >Import : http://localhost/wsbuildfax/buildfax.asmx?wsdl:0
// Encoding : utf-8
// Version  : 1.0
// (07/22/2011 1:46:09 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit BuildfaxBTService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsGetReportData     = class;                 { "http://bradfordsoftware.com/"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsGetReportData, global, <complexType>
  // Namespace : http://bradfordsoftware.com/
  // ************************************************************************ //
  clsGetReportData = class(TRemotable)
  private
    FBuildFaxReport: WideString;
    FBuildFaxReport_Specified: boolean;
    FData: WideString;
    FData_Specified: boolean;
    FBadAddresses: WideString;
    FBadAddresses_Specified: boolean;
    procedure SetBuildFaxReport(Index: Integer; const AWideString: WideString);
    function  BuildFaxReport_Specified(Index: Integer): boolean;
    procedure SetData(Index: Integer; const AWideString: WideString);
    function  Data_Specified(Index: Integer): boolean;
    procedure SetBadAddresses(Index: Integer; const AWideString: WideString);
    function  BadAddresses_Specified(Index: Integer): boolean;
  published
    property BuildFaxReport: WideString  Index (IS_OPTN) read FBuildFaxReport write SetBuildFaxReport stored BuildFaxReport_Specified;
    property Data:           WideString  Index (IS_OPTN) read FData write SetData stored Data_Specified;
    property BadAddresses:   WideString  Index (IS_OPTN) read FBadAddresses write SetBadAddresses stored BadAddresses_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://bradfordsoftware.com/
  // soapAction: http://bradfordsoftware.com/GetBuildFaxData
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : BuildfaxServiceSoap
  // service   : BuildfaxService
  // port      : BuildfaxServiceSoap
  // URL       : http://localhost/wsbuildfax/buildfax.asmx
  // ************************************************************************ //
  BuildfaxServiceSoap = interface(IInvokable)
  ['{619081DA-AD91-D287-69A2-720A44315FDB}']
    function  GetBuildFaxData(const pin: WideString; const addrs: WideString; const custID: Integer): clsGetReportData; stdcall;
  end;

function GetBuildfaxServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): BuildfaxServiceSoap;


implementation
  uses SysUtils;

function GetBuildfaxServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): BuildfaxServiceSoap;
const
  defWSDL = 'http://10.0.0.183/wsbuildfax/buildfax.asmx?wsdl';
  defURL  = 'http://l0.0.0.183/wsbuildfax/buildfax.asmx';
  defSvc  = 'BuildfaxService';
  defPrt  = 'BuildfaxServiceSoap';
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
    Result := (RIO as BuildfaxServiceSoap);
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


procedure clsGetReportData.SetBuildFaxReport(Index: Integer; const AWideString: WideString);
begin
  FBuildFaxReport := AWideString;
  FBuildFaxReport_Specified := True;
end;

function clsGetReportData.BuildFaxReport_Specified(Index: Integer): boolean;
begin
  Result := FBuildFaxReport_Specified;
end;

procedure clsGetReportData.SetData(Index: Integer; const AWideString: WideString);
begin
  FData := AWideString;
  FData_Specified := True;
end;

function clsGetReportData.Data_Specified(Index: Integer): boolean;
begin
  Result := FData_Specified;
end;

procedure clsGetReportData.SetBadAddresses(Index: Integer; const AWideString: WideString);
begin
  FBadAddresses := AWideString;
  FBadAddresses_Specified := True;
end;

function clsGetReportData.BadAddresses_Specified(Index: Integer): boolean;
begin
  Result := FBadAddresses_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(BuildfaxServiceSoap), 'http://bradfordsoftware.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(BuildfaxServiceSoap), 'http://bradfordsoftware.com/GetBuildFaxData');
  InvRegistry.RegisterInvokeOptions(TypeInfo(BuildfaxServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(clsGetReportData, 'http://bradfordsoftware.com/', 'clsGetReportData');

end.