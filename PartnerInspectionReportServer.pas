// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme.atbx.net/secure/ws/awsi/PartnerInspectionReportServer.php?wsdl
//  >Import : http://carme.atbx.net/secure/ws/awsi/PartnerInspectionReportServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (1/31/2014 12:49:15 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit PartnerInspectionReportServer;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;


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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsAccessCredentials = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddOrderResponse  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAssignAppraiserResponse = class;           { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCancelOrderResponse = class;               { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsValidateAppraiserIDResponse = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsOrderDetailsData  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddOrderRequest   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAssignAppraiserRequest = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCancelOrderRequest = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsValidateAppraiserIDRequest = class;        { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsAccessCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAccessCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FAccessId: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
    property AccessId: WideString  read FAccessId write FAccessId;
  end;



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code:        Integer     read FCode write FCode;
    property Type_:       WideString  read FType_ write FType_;
    property Description: WideString  read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // XML       : clsAddOrderResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddOrderResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: WideString;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: WideString  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAssignAppraiserResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAssignAppraiserResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: Boolean;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: Boolean     read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsCancelOrderResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCancelOrderResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: Boolean;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: Boolean     read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsValidateAppraiserIDResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsValidateAppraiserIDResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: Boolean;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: Boolean     read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsOrderDetailsData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsOrderDetailsData = class(TRemotable)
  private
    FOrderID: Integer;
    FServiceID: Integer;
    FPONumber: WideString;
    FPONumber_Specified: boolean;
    FOrderPrice: WideString;
    FOrderPrice_Specified: boolean;
    FReportHTML: WideString;
    FReportHTML_Specified: boolean;
    procedure SetPONumber(Index: Integer; const AWideString: WideString);
    function  PONumber_Specified(Index: Integer): boolean;
    procedure SetOrderPrice(Index: Integer; const AWideString: WideString);
    function  OrderPrice_Specified(Index: Integer): boolean;
    procedure SetReportHTML(Index: Integer; const AWideString: WideString);
    function  ReportHTML_Specified(Index: Integer): boolean;
  published
    property OrderID:    Integer     read FOrderID write FOrderID;
    property ServiceID:  Integer     read FServiceID write FServiceID;
    property PONumber:   WideString  Index (IS_OPTN) read FPONumber write SetPONumber stored PONumber_Specified;
    property OrderPrice: WideString  Index (IS_OPTN) read FOrderPrice write SetOrderPrice stored OrderPrice_Specified;
    property ReportHTML: WideString  Index (IS_OPTN) read FReportHTML write SetReportHTML stored ReportHTML_Specified;
  end;

  clsOrderDetailsArray = array of clsOrderDetailsData;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsAddOrderRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddOrderRequest = class(TRemotable)
  private
    FInspectionCompanyID: WideString;
    FAppraiserID: WideString;
    FAppraiserID_Specified: boolean;
    FOrderID: Integer;
    FClientID: Integer;
    FUserID: Integer;
    FPONumber: WideString;
    FPONumber_Specified: boolean;
    FdbaName: WideString;
    FdbaName_Specified: boolean;
    FFileNumber: WideString;
    FPropertyID: WideString;
    FPropertyID_Specified: boolean;
    FPropOwner: WideString;
    FPropAddress: WideString;
    FPropCity: WideString;
    FPropState: WideString;
    FPropZip: WideString;
    FPropDesc: WideString;
    FPropDesc_Specified: boolean;
    FmobYear: WideString;
    FmobYear_Specified: boolean;
    FmobMake: WideString;
    FmobMake_Specified: boolean;
    FmobModel: WideString;
    FmobModel_Specified: boolean;
    FmobSerial: WideString;
    FmobSerial_Specified: boolean;
    FmobLength: WideString;
    FmobLength_Specified: boolean;
    FmobWidth: WideString;
    FmobWidth_Specified: boolean;
    FmobColor: WideString;
    FmobColor_Specified: boolean;
    FUnitType: WideString;
    FUnitType_Specified: boolean;
    FUnitCount: WideString;
    FUnitCount_Specified: boolean;
    FHUD: WideString;
    FHUD_Specified: boolean;
    FAccContact: WideString;
    FAccMobile: WideString;
    FAccMobile_Specified: boolean;
    FAccFax: WideString;
    FAccFax_Specified: boolean;
    FAccHome: WideString;
    FAccHome_Specified: boolean;
    FAccWork: WideString;
    FAccWork_Specified: boolean;
    FAccEmail: WideString;
    FAccEmail_Specified: boolean;
    FAccWeb: WideString;
    FAccWeb_Specified: boolean;
    FOtherData: WideString;
    FOtherData_Specified: boolean;
    FRushStatus: WideString;
    FAuctionDate: WideString;
    FAuctionDate_Specified: boolean;
    FNotes: WideString;
    FNotes_Specified: boolean;
    FCallbackReference: WideString;
    FCallbackReference_Specified: boolean;
    FClientHoldDate: WideString;
    FClientHoldDate_Specified: boolean;
    FOrderDetails: clsOrderDetailsArray;
    procedure SetAppraiserID(Index: Integer; const AWideString: WideString);
    function  AppraiserID_Specified(Index: Integer): boolean;
    procedure SetPONumber(Index: Integer; const AWideString: WideString);
    function  PONumber_Specified(Index: Integer): boolean;
    procedure SetdbaName(Index: Integer; const AWideString: WideString);
    function  dbaName_Specified(Index: Integer): boolean;
    procedure SetPropertyID(Index: Integer; const AWideString: WideString);
    function  PropertyID_Specified(Index: Integer): boolean;
    procedure SetPropDesc(Index: Integer; const AWideString: WideString);
    function  PropDesc_Specified(Index: Integer): boolean;
    procedure SetmobYear(Index: Integer; const AWideString: WideString);
    function  mobYear_Specified(Index: Integer): boolean;
    procedure SetmobMake(Index: Integer; const AWideString: WideString);
    function  mobMake_Specified(Index: Integer): boolean;
    procedure SetmobModel(Index: Integer; const AWideString: WideString);
    function  mobModel_Specified(Index: Integer): boolean;
    procedure SetmobSerial(Index: Integer; const AWideString: WideString);
    function  mobSerial_Specified(Index: Integer): boolean;
    procedure SetmobLength(Index: Integer; const AWideString: WideString);
    function  mobLength_Specified(Index: Integer): boolean;
    procedure SetmobWidth(Index: Integer; const AWideString: WideString);
    function  mobWidth_Specified(Index: Integer): boolean;
    procedure SetmobColor(Index: Integer; const AWideString: WideString);
    function  mobColor_Specified(Index: Integer): boolean;
    procedure SetUnitType(Index: Integer; const AWideString: WideString);
    function  UnitType_Specified(Index: Integer): boolean;
    procedure SetUnitCount(Index: Integer; const AWideString: WideString);
    function  UnitCount_Specified(Index: Integer): boolean;
    procedure SetHUD(Index: Integer; const AWideString: WideString);
    function  HUD_Specified(Index: Integer): boolean;
    procedure SetAccMobile(Index: Integer; const AWideString: WideString);
    function  AccMobile_Specified(Index: Integer): boolean;
    procedure SetAccFax(Index: Integer; const AWideString: WideString);
    function  AccFax_Specified(Index: Integer): boolean;
    procedure SetAccHome(Index: Integer; const AWideString: WideString);
    function  AccHome_Specified(Index: Integer): boolean;
    procedure SetAccWork(Index: Integer; const AWideString: WideString);
    function  AccWork_Specified(Index: Integer): boolean;
    procedure SetAccEmail(Index: Integer; const AWideString: WideString);
    function  AccEmail_Specified(Index: Integer): boolean;
    procedure SetAccWeb(Index: Integer; const AWideString: WideString);
    function  AccWeb_Specified(Index: Integer): boolean;
    procedure SetOtherData(Index: Integer; const AWideString: WideString);
    function  OtherData_Specified(Index: Integer): boolean;
    procedure SetAuctionDate(Index: Integer; const AWideString: WideString);
    function  AuctionDate_Specified(Index: Integer): boolean;
    procedure SetNotes(Index: Integer; const AWideString: WideString);
    function  Notes_Specified(Index: Integer): boolean;
    procedure SetCallbackReference(Index: Integer; const AWideString: WideString);
    function  CallbackReference_Specified(Index: Integer): boolean;
    procedure SetClientHoldDate(Index: Integer; const AWideString: WideString);
    function  ClientHoldDate_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property InspectionCompanyID: WideString            read FInspectionCompanyID write FInspectionCompanyID;
    property AppraiserID:         WideString            Index (IS_OPTN) read FAppraiserID write SetAppraiserID stored AppraiserID_Specified;
    property OrderID:             Integer               read FOrderID write FOrderID;
    property ClientID:            Integer               read FClientID write FClientID;
    property UserID:              Integer               read FUserID write FUserID;
    property PONumber:            WideString            Index (IS_OPTN) read FPONumber write SetPONumber stored PONumber_Specified;
    property dbaName:             WideString            Index (IS_OPTN) read FdbaName write SetdbaName stored dbaName_Specified;
    property FileNumber:          WideString            read FFileNumber write FFileNumber;
    property PropertyID:          WideString            Index (IS_OPTN) read FPropertyID write SetPropertyID stored PropertyID_Specified;
    property PropOwner:           WideString            read FPropOwner write FPropOwner;
    property PropAddress:         WideString            read FPropAddress write FPropAddress;
    property PropCity:            WideString            read FPropCity write FPropCity;
    property PropState:           WideString            read FPropState write FPropState;
    property PropZip:             WideString            read FPropZip write FPropZip;
    property PropDesc:            WideString            Index (IS_OPTN) read FPropDesc write SetPropDesc stored PropDesc_Specified;
    property mobYear:             WideString            Index (IS_OPTN) read FmobYear write SetmobYear stored mobYear_Specified;
    property mobMake:             WideString            Index (IS_OPTN) read FmobMake write SetmobMake stored mobMake_Specified;
    property mobModel:            WideString            Index (IS_OPTN) read FmobModel write SetmobModel stored mobModel_Specified;
    property mobSerial:           WideString            Index (IS_OPTN) read FmobSerial write SetmobSerial stored mobSerial_Specified;
    property mobLength:           WideString            Index (IS_OPTN) read FmobLength write SetmobLength stored mobLength_Specified;
    property mobWidth:            WideString            Index (IS_OPTN) read FmobWidth write SetmobWidth stored mobWidth_Specified;
    property mobColor:            WideString            Index (IS_OPTN) read FmobColor write SetmobColor stored mobColor_Specified;
    property UnitType:            WideString            Index (IS_OPTN) read FUnitType write SetUnitType stored UnitType_Specified;
    property UnitCount:           WideString            Index (IS_OPTN) read FUnitCount write SetUnitCount stored UnitCount_Specified;
    property HUD:                 WideString            Index (IS_OPTN) read FHUD write SetHUD stored HUD_Specified;
    property AccContact:          WideString            read FAccContact write FAccContact;
    property AccMobile:           WideString            Index (IS_OPTN) read FAccMobile write SetAccMobile stored AccMobile_Specified;
    property AccFax:              WideString            Index (IS_OPTN) read FAccFax write SetAccFax stored AccFax_Specified;
    property AccHome:             WideString            Index (IS_OPTN) read FAccHome write SetAccHome stored AccHome_Specified;
    property AccWork:             WideString            Index (IS_OPTN) read FAccWork write SetAccWork stored AccWork_Specified;
    property AccEmail:            WideString            Index (IS_OPTN) read FAccEmail write SetAccEmail stored AccEmail_Specified;
    property AccWeb:              WideString            Index (IS_OPTN) read FAccWeb write SetAccWeb stored AccWeb_Specified;
    property OtherData:           WideString            Index (IS_OPTN) read FOtherData write SetOtherData stored OtherData_Specified;
    property RushStatus:          WideString            read FRushStatus write FRushStatus;
    property AuctionDate:         WideString            Index (IS_OPTN) read FAuctionDate write SetAuctionDate stored AuctionDate_Specified;
    property Notes:               WideString            Index (IS_OPTN) read FNotes write SetNotes stored Notes_Specified;
    property CallbackReference:   WideString            Index (IS_OPTN) read FCallbackReference write SetCallbackReference stored CallbackReference_Specified;
    property ClientHoldDate:      WideString            Index (IS_OPTN) read FClientHoldDate write SetClientHoldDate stored ClientHoldDate_Specified;
    property OrderDetails:        clsOrderDetailsArray  read FOrderDetails write FOrderDetails;
  end;



  // ************************************************************************ //
  // XML       : clsAssignAppraiserRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAssignAppraiserRequest = class(TRemotable)
  private
    FReportID: WideString;
    FAppraiserID: WideString;
  published
    property ReportID:    WideString  read FReportID write FReportID;
    property AppraiserID: WideString  read FAppraiserID write FAppraiserID;
  end;



  // ************************************************************************ //
  // XML       : clsCancelOrderRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCancelOrderRequest = class(TRemotable)
  private
    FFileNumber: WideString;
    FNote: WideString;
  published
    property FileNumber: WideString  read FFileNumber write FFileNumber;
    property Note:       WideString  read FNote write FNote;
  end;



  // ************************************************************************ //
  // XML       : clsValidateAppraiserIDRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsValidateAppraiserIDRequest = class(TRemotable)
  private
    FAppraiserID: WideString;
  published
    property AppraiserID: WideString  read FAppraiserID write FAppraiserID;
  end;


  // ************************************************************************ //
  // Namespace : PartnerInspectionReportServerClass
  // soapAction: PartnerInspectionReportServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : PartnerInspectionReportServerBinding
  // service   : PartnerInspectionReportServer
  // port      : PartnerInspectionReportServerPort
  // URL       : http://carme.atbx.net/secure/ws/awsi/PartnerInspectionReportServer.php
  // ************************************************************************ //
  PartnerInspectionReportServerPortType = interface(IInvokable)
  ['{A27DE51B-BCCC-E67A-2AB7-8F661F28957D}']
    function  PartnerInspectionReportServices_AddOrder(const UserCredentials: clsAccessCredentials; const RequestDetails: clsAddOrderRequest): clsAddOrderResponse; stdcall;
    function  PartnerInspectionReportServices_AssignAppraiser(const UserCredentials: clsAccessCredentials; const RequestDetails: clsAssignAppraiserRequest): clsAssignAppraiserResponse; stdcall;
    function  PartnerInspectionReportServices_CancelOrder(const UserCredentials: clsAccessCredentials; const RequestDetails: clsCancelOrderRequest): clsCancelOrderResponse; stdcall;
    function  PartnerInspectionReportServices_ValidateAppraiserID(const UserCredentials: clsAccessCredentials; const RequestDetails: clsValidateAppraiserIDRequest): clsValidateAppraiserIDResponse; stdcall;
  end;

function GetPartnerInspectionReportServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PartnerInspectionReportServerPortType;


implementation
  uses SysUtils;

function GetPartnerInspectionReportServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PartnerInspectionReportServerPortType;
const
  defWSDL = 'http://carme.atbx.net/secure/ws/awsi/PartnerInspectionReportServer.php?wsdl';
  defURL  = 'http://carme.atbx.net/secure/ws/awsi/PartnerInspectionReportServer.php';
  defSvc  = 'PartnerInspectionReportServer';
  defPrt  = 'PartnerInspectionReportServerPort';
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
    Result := (RIO as PartnerInspectionReportServerPortType);
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


destructor clsAddOrderResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsAssignAppraiserResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsCancelOrderResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsValidateAppraiserIDResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

procedure clsOrderDetailsData.SetPONumber(Index: Integer; const AWideString: WideString);
begin
  FPONumber := AWideString;
  FPONumber_Specified := True;
end;

function clsOrderDetailsData.PONumber_Specified(Index: Integer): boolean;
begin
  Result := FPONumber_Specified;
end;

procedure clsOrderDetailsData.SetOrderPrice(Index: Integer; const AWideString: WideString);
begin
  FOrderPrice := AWideString;
  FOrderPrice_Specified := True;
end;

function clsOrderDetailsData.OrderPrice_Specified(Index: Integer): boolean;
begin
  Result := FOrderPrice_Specified;
end;

procedure clsOrderDetailsData.SetReportHTML(Index: Integer; const AWideString: WideString);
begin
  FReportHTML := AWideString;
  FReportHTML_Specified := True;
end;

function clsOrderDetailsData.ReportHTML_Specified(Index: Integer): boolean;
begin
  Result := FReportHTML_Specified;
end;

destructor clsAddOrderRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FOrderDetails)-1 do
    FreeAndNil(FOrderDetails[I]);
  SetLength(FOrderDetails, 0);
  inherited Destroy;
end;

procedure clsAddOrderRequest.SetAppraiserID(Index: Integer; const AWideString: WideString);
begin
  FAppraiserID := AWideString;
  FAppraiserID_Specified := True;
end;

function clsAddOrderRequest.AppraiserID_Specified(Index: Integer): boolean;
begin
  Result := FAppraiserID_Specified;
end;

procedure clsAddOrderRequest.SetPONumber(Index: Integer; const AWideString: WideString);
begin
  FPONumber := AWideString;
  FPONumber_Specified := True;
end;

function clsAddOrderRequest.PONumber_Specified(Index: Integer): boolean;
begin
  Result := FPONumber_Specified;
end;

procedure clsAddOrderRequest.SetdbaName(Index: Integer; const AWideString: WideString);
begin
  FdbaName := AWideString;
  FdbaName_Specified := True;
end;

function clsAddOrderRequest.dbaName_Specified(Index: Integer): boolean;
begin
  Result := FdbaName_Specified;
end;

procedure clsAddOrderRequest.SetPropertyID(Index: Integer; const AWideString: WideString);
begin
  FPropertyID := AWideString;
  FPropertyID_Specified := True;
end;

function clsAddOrderRequest.PropertyID_Specified(Index: Integer): boolean;
begin
  Result := FPropertyID_Specified;
end;

procedure clsAddOrderRequest.SetPropDesc(Index: Integer; const AWideString: WideString);
begin
  FPropDesc := AWideString;
  FPropDesc_Specified := True;
end;

function clsAddOrderRequest.PropDesc_Specified(Index: Integer): boolean;
begin
  Result := FPropDesc_Specified;
end;

procedure clsAddOrderRequest.SetmobYear(Index: Integer; const AWideString: WideString);
begin
  FmobYear := AWideString;
  FmobYear_Specified := True;
end;

function clsAddOrderRequest.mobYear_Specified(Index: Integer): boolean;
begin
  Result := FmobYear_Specified;
end;

procedure clsAddOrderRequest.SetmobMake(Index: Integer; const AWideString: WideString);
begin
  FmobMake := AWideString;
  FmobMake_Specified := True;
end;

function clsAddOrderRequest.mobMake_Specified(Index: Integer): boolean;
begin
  Result := FmobMake_Specified;
end;

procedure clsAddOrderRequest.SetmobModel(Index: Integer; const AWideString: WideString);
begin
  FmobModel := AWideString;
  FmobModel_Specified := True;
end;

function clsAddOrderRequest.mobModel_Specified(Index: Integer): boolean;
begin
  Result := FmobModel_Specified;
end;

procedure clsAddOrderRequest.SetmobSerial(Index: Integer; const AWideString: WideString);
begin
  FmobSerial := AWideString;
  FmobSerial_Specified := True;
end;

function clsAddOrderRequest.mobSerial_Specified(Index: Integer): boolean;
begin
  Result := FmobSerial_Specified;
end;

procedure clsAddOrderRequest.SetmobLength(Index: Integer; const AWideString: WideString);
begin
  FmobLength := AWideString;
  FmobLength_Specified := True;
end;

function clsAddOrderRequest.mobLength_Specified(Index: Integer): boolean;
begin
  Result := FmobLength_Specified;
end;

procedure clsAddOrderRequest.SetmobWidth(Index: Integer; const AWideString: WideString);
begin
  FmobWidth := AWideString;
  FmobWidth_Specified := True;
end;

function clsAddOrderRequest.mobWidth_Specified(Index: Integer): boolean;
begin
  Result := FmobWidth_Specified;
end;

procedure clsAddOrderRequest.SetmobColor(Index: Integer; const AWideString: WideString);
begin
  FmobColor := AWideString;
  FmobColor_Specified := True;
end;

function clsAddOrderRequest.mobColor_Specified(Index: Integer): boolean;
begin
  Result := FmobColor_Specified;
end;

procedure clsAddOrderRequest.SetUnitType(Index: Integer; const AWideString: WideString);
begin
  FUnitType := AWideString;
  FUnitType_Specified := True;
end;

function clsAddOrderRequest.UnitType_Specified(Index: Integer): boolean;
begin
  Result := FUnitType_Specified;
end;

procedure clsAddOrderRequest.SetUnitCount(Index: Integer; const AWideString: WideString);
begin
  FUnitCount := AWideString;
  FUnitCount_Specified := True;
end;

function clsAddOrderRequest.UnitCount_Specified(Index: Integer): boolean;
begin
  Result := FUnitCount_Specified;
end;

procedure clsAddOrderRequest.SetHUD(Index: Integer; const AWideString: WideString);
begin
  FHUD := AWideString;
  FHUD_Specified := True;
end;

function clsAddOrderRequest.HUD_Specified(Index: Integer): boolean;
begin
  Result := FHUD_Specified;
end;

procedure clsAddOrderRequest.SetAccMobile(Index: Integer; const AWideString: WideString);
begin
  FAccMobile := AWideString;
  FAccMobile_Specified := True;
end;

function clsAddOrderRequest.AccMobile_Specified(Index: Integer): boolean;
begin
  Result := FAccMobile_Specified;
end;

procedure clsAddOrderRequest.SetAccFax(Index: Integer; const AWideString: WideString);
begin
  FAccFax := AWideString;
  FAccFax_Specified := True;
end;

function clsAddOrderRequest.AccFax_Specified(Index: Integer): boolean;
begin
  Result := FAccFax_Specified;
end;

procedure clsAddOrderRequest.SetAccHome(Index: Integer; const AWideString: WideString);
begin
  FAccHome := AWideString;
  FAccHome_Specified := True;
end;

function clsAddOrderRequest.AccHome_Specified(Index: Integer): boolean;
begin
  Result := FAccHome_Specified;
end;

procedure clsAddOrderRequest.SetAccWork(Index: Integer; const AWideString: WideString);
begin
  FAccWork := AWideString;
  FAccWork_Specified := True;
end;

function clsAddOrderRequest.AccWork_Specified(Index: Integer): boolean;
begin
  Result := FAccWork_Specified;
end;

procedure clsAddOrderRequest.SetAccEmail(Index: Integer; const AWideString: WideString);
begin
  FAccEmail := AWideString;
  FAccEmail_Specified := True;
end;

function clsAddOrderRequest.AccEmail_Specified(Index: Integer): boolean;
begin
  Result := FAccEmail_Specified;
end;

procedure clsAddOrderRequest.SetAccWeb(Index: Integer; const AWideString: WideString);
begin
  FAccWeb := AWideString;
  FAccWeb_Specified := True;
end;

function clsAddOrderRequest.AccWeb_Specified(Index: Integer): boolean;
begin
  Result := FAccWeb_Specified;
end;

procedure clsAddOrderRequest.SetOtherData(Index: Integer; const AWideString: WideString);
begin
  FOtherData := AWideString;
  FOtherData_Specified := True;
end;

function clsAddOrderRequest.OtherData_Specified(Index: Integer): boolean;
begin
  Result := FOtherData_Specified;
end;

procedure clsAddOrderRequest.SetAuctionDate(Index: Integer; const AWideString: WideString);
begin
  FAuctionDate := AWideString;
  FAuctionDate_Specified := True;
end;

function clsAddOrderRequest.AuctionDate_Specified(Index: Integer): boolean;
begin
  Result := FAuctionDate_Specified;
end;

procedure clsAddOrderRequest.SetNotes(Index: Integer; const AWideString: WideString);
begin
  FNotes := AWideString;
  FNotes_Specified := True;
end;

function clsAddOrderRequest.Notes_Specified(Index: Integer): boolean;
begin
  Result := FNotes_Specified;
end;

procedure clsAddOrderRequest.SetCallbackReference(Index: Integer; const AWideString: WideString);
begin
  FCallbackReference := AWideString;
  FCallbackReference_Specified := True;
end;

function clsAddOrderRequest.CallbackReference_Specified(Index: Integer): boolean;
begin
  Result := FCallbackReference_Specified;
end;

procedure clsAddOrderRequest.SetClientHoldDate(Index: Integer; const AWideString: WideString);
begin
  FClientHoldDate := AWideString;
  FClientHoldDate_Specified := True;
end;

function clsAddOrderRequest.ClientHoldDate_Specified(Index: Integer): boolean;
begin
  Result := FClientHoldDate_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServices_AddOrder', 'PartnerInspectionReportServices.AddOrder');
  InvRegistry.RegisterExternalMethName(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServices_AssignAppraiser', 'PartnerInspectionReportServices.AssignAppraiser');
  InvRegistry.RegisterExternalMethName(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServices_CancelOrder', 'PartnerInspectionReportServices.CancelOrder');
  InvRegistry.RegisterExternalMethName(TypeInfo(PartnerInspectionReportServerPortType), 'PartnerInspectionReportServices_ValidateAppraiserID', 'PartnerInspectionReportServices.ValidateAppraiserID');
  RemClassRegistry.RegisterXSClass(clsAccessCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAccessCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme.atbx.net/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAddOrderResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddOrderResponse');
  RemClassRegistry.RegisterXSClass(clsAssignAppraiserResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAssignAppraiserResponse');
  RemClassRegistry.RegisterXSClass(clsCancelOrderResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCancelOrderResponse');
  RemClassRegistry.RegisterXSClass(clsValidateAppraiserIDResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsValidateAppraiserIDResponse');
  RemClassRegistry.RegisterXSClass(clsOrderDetailsData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsOrderDetailsData');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsOrderDetailsArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsOrderDetailsArray');
  RemClassRegistry.RegisterXSClass(clsAddOrderRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddOrderRequest');
  RemClassRegistry.RegisterXSClass(clsAssignAppraiserRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAssignAppraiserRequest');
  RemClassRegistry.RegisterXSClass(clsCancelOrderRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCancelOrderRequest');
  RemClassRegistry.RegisterXSClass(clsValidateAppraiserIDRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsValidateAppraiserIDRequest');

end.