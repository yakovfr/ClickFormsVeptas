// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\temp\AwsiAccessServer_php.wsdl
//  >Import : C:\temp\AwsiAccessServer_php.wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (7/8/2014 2:41:37 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit Awsi_Server_Access;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsOffsetPoint       = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsDisplayRectangle  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetExistingOrderData = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetOrderData      = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUpdateMemberInformationResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponse = class;           { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponseData = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClientVersionResponse = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClientVersionData = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetNewOrderResponse = class;               { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetOrder2Data     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetNewOrder2Response = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetOrder3Data     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetNewOrder3Response = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetExistingOrderResponse = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddLenderReferenceResponse = class;        { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetSecurityTokenResponse = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetSecurityTokenData = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetSignatureDetailsData = class;           { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetSignatureDetailsResponse = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetSignatureLastChangeDateResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsInitializeConnectionResponse = class;      { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsInitializeConnectionData = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsProductListItem   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsPromotionListItem = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsIsMemberResponseData = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsIsMemberResponse  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMemberInformationResponse = class;      { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMemberInformationData = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsLicenseItem       = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMemberInformation2Data = class;         { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMemberInformation2Response = class;     { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSendMessageResponse = class;               { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSendExternalEmailResponse = class;         { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClickformsSecurityTokenResponseData = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClickformsSecurityTokenResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAttachmentListItem = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsToListItem        = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAccessCredentials = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAwsiOrderDetailsRequest = class;           { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddressDetails    = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsNewOrderDetails   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMemberInformationCredentials = class;      { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgement   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClientVersionRequest = class;           { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAwsiNewOrderDetailsRequest = class;        { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAwsiNewOrder2DetailsRequest = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAwsiNewOrder3DetailsRequest = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsLenderReferenceDetails = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAwsiAccessDetailsRequest = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsIsMemberCredentials = class;               { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMemberInformationCredentials = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSendMessageCredentials = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSendMessageRequest = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSendExternalEmailRequest = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUpdateMemberInformationData = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUpdateMemberInformationCredentials = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSignatureUpdateDetails = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUpdateMemberInformation2Data = class;      { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetClickformsSecurityTokenCredentials = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsOpenOrderListItem = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCompanyListItem   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsOffsetPoint, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsOffsetPoint = class(TRemotable)
  private
    FPointA: Integer;
    FPointB: Integer;
  published
    property PointA: Integer  read FPointA write FPointA;
    property PointB: Integer  read FPointB write FPointB;
  end;



  // ************************************************************************ //
  // XML       : clsDisplayRectangle, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsDisplayRectangle = class(TRemotable)
  private
    FPointA: Integer;
    FPointB: Integer;
    FPointC: Integer;
    FPointD: Integer;
  published
    property PointA: Integer  read FPointA write FPointA;
    property PointB: Integer  read FPointB write FPointB;
    property PointC: Integer  read FPointC write FPointC;
    property PointD: Integer  read FPointD write FPointD;
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
  // XML       : clsGetExistingOrderData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetExistingOrderData = class(TRemotable)
  private
    FOrderKey: WideString;
    FOrderNumber: WideString;
    FOrderNumber_Specified: boolean;
    procedure SetOrderNumber(Index: Integer; const AWideString: WideString);
    function  OrderNumber_Specified(Index: Integer): boolean;
  published
    property OrderKey:    WideString  read FOrderKey write FOrderKey;
    property OrderNumber: WideString  Index (IS_OPTN) read FOrderNumber write SetOrderNumber stored OrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetOrderData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetOrderData = class(TRemotable)
  private
    FOrderKey: WideString;
  published
    property OrderKey: WideString  read FOrderKey write FOrderKey;
  end;



  // ************************************************************************ //
  // XML       : clsUpdateMemberInformationResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUpdateMemberInformationResponse = class(TRemotable)
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
  // XML       : clsAcknowledgementResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer  read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // XML       : clsGetClientVersionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClientVersionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetClientVersionData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults               read FResults write FResults;
    property ResponseData: clsGetClientVersionData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetClientVersionData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClientVersionData = class(TRemotable)
  private
    FApplicationVersion: WideString;
    FApplicationVersionDate: WideString;
    FUpdateRequired: Integer;
  published
    property ApplicationVersion:     WideString  read FApplicationVersion write FApplicationVersion;
    property ApplicationVersionDate: WideString  read FApplicationVersionDate write FApplicationVersionDate;
    property UpdateRequired:         Integer     read FUpdateRequired write FUpdateRequired;
  end;



  // ************************************************************************ //
  // XML       : clsGetNewOrderResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNewOrderResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetOrderData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults       read FResults write FResults;
    property ResponseData: clsGetOrderData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetOrder2Data, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetOrder2Data = class(TRemotable)
  private
    FOrderKey: WideString;
    FOrderNumber: WideString;
    FOrderNumber_Specified: boolean;
    procedure SetOrderNumber(Index: Integer; const AWideString: WideString);
    function  OrderNumber_Specified(Index: Integer): boolean;
  published
    property OrderKey:    WideString  read FOrderKey write FOrderKey;
    property OrderNumber: WideString  Index (IS_OPTN) read FOrderNumber write SetOrderNumber stored OrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetNewOrder2Response, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNewOrder2Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetOrder2Data;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults        read FResults write FResults;
    property ResponseData: clsGetOrder2Data  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetOrder3Data, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetOrder3Data = class(TRemotable)
  private
    FOrderKey: WideString;
    FCompanyKey: WideString;
    FOrderNumber: WideString;
    FOrderNumber_Specified: boolean;
    procedure SetOrderNumber(Index: Integer; const AWideString: WideString);
    function  OrderNumber_Specified(Index: Integer): boolean;
  published
    property OrderKey:    WideString  read FOrderKey write FOrderKey;
    property CompanyKey:  WideString  read FCompanyKey write FCompanyKey;
    property OrderNumber: WideString  Index (IS_OPTN) read FOrderNumber write SetOrderNumber stored OrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetNewOrder3Response, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNewOrder3Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetOrder3Data;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults        read FResults write FResults;
    property ResponseData: clsGetOrder3Data  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetExistingOrderResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetExistingOrderResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetExistingOrderData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults               read FResults write FResults;
    property ResponseData: clsGetExistingOrderData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAddLenderReferenceResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddLenderReferenceResponse = class(TRemotable)
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
  // XML       : clsGetSecurityTokenResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetSecurityTokenData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults               read FResults write FResults;
    property ResponseData: clsGetSecurityTokenData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetSecurityTokenData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenData = class(TRemotable)
  private
    FSecurityToken: WideString;
  published
    property SecurityToken: WideString  read FSecurityToken write FSecurityToken;
  end;



  // ************************************************************************ //
  // XML       : clsGetSignatureDetailsData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSignatureDetailsData = class(TRemotable)
  private
    FSignatureFullName: WideString;
    FSignatureCompanyName: WideString;
    FSignatureImage: WideString;
    FSignatureLastUpdateDate: WideString;
    FSignatureOffsetPoint: clsOffsetPoint;
    FSignatureDisplayRectangle: clsDisplayRectangle;
  public
    destructor Destroy; override;
  published
    property SignatureFullName:         WideString           read FSignatureFullName write FSignatureFullName;
    property SignatureCompanyName:      WideString           read FSignatureCompanyName write FSignatureCompanyName;
    property SignatureImage:            WideString           read FSignatureImage write FSignatureImage;
    property SignatureLastUpdateDate:   WideString           read FSignatureLastUpdateDate write FSignatureLastUpdateDate;
    property SignatureOffsetPoint:      clsOffsetPoint       read FSignatureOffsetPoint write FSignatureOffsetPoint;
    property SignatureDisplayRectangle: clsDisplayRectangle  read FSignatureDisplayRectangle write FSignatureDisplayRectangle;
  end;



  // ************************************************************************ //
  // XML       : clsGetSignatureDetailsResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSignatureDetailsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetSignatureDetailsData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                  read FResults write FResults;
    property ResponseData: clsGetSignatureDetailsData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetSignatureLastChangeDateResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSignatureLastChangeDateResponse = class(TRemotable)
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
  // XML       : clsInitializeConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsInitializeConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsInitializeConnectionData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsInitializeConnectionData  read FResponseData write FResponseData;
  end;

  clsCompanyList = array of clsCompanyListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsProductList = array of clsProductListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsOpenOrderList = array of clsOpenOrderListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsPromotionList = array of clsPromotionListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsInitializeConnectionData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsInitializeConnectionData = class(TRemotable)
  private
    FCompanyList: clsCompanyList;
    FProductList: clsProductList;
    FOpenOrderList: clsOpenOrderList;
    FOpenOrderList_Specified: boolean;
    FPromotionList: clsPromotionList;
    FPromotionList_Specified: boolean;
    procedure SetOpenOrderList(Index: Integer; const AclsOpenOrderList: clsOpenOrderList);
    function  OpenOrderList_Specified(Index: Integer): boolean;
    procedure SetPromotionList(Index: Integer; const AclsPromotionList: clsPromotionList);
    function  PromotionList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CompanyList:   clsCompanyList    read FCompanyList write FCompanyList;
    property ProductList:   clsProductList    read FProductList write FProductList;
    property OpenOrderList: clsOpenOrderList  Index (IS_OPTN) read FOpenOrderList write SetOpenOrderList stored OpenOrderList_Specified;
    property PromotionList: clsPromotionList  Index (IS_OPTN) read FPromotionList write SetPromotionList stored PromotionList_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsProductListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsProductListItem = class(TRemotable)
  private
    FProductName: WideString;
    FProductDescription: WideString;
    FProductKey: WideString;
    FProductUnitPrice: Single;
  published
    property ProductName:        WideString  read FProductName write FProductName;
    property ProductDescription: WideString  read FProductDescription write FProductDescription;
    property ProductKey:         WideString  read FProductKey write FProductKey;
    property ProductUnitPrice:   Single      read FProductUnitPrice write FProductUnitPrice;
  end;



  // ************************************************************************ //
  // XML       : clsPromotionListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsPromotionListItem = class(TRemotable)
  private
    FPromotionName: WideString;
    FPromotionDescription: WideString;
    FPromotionKey: WideString;
    FPromotionUnitPrice: Single;
  published
    property PromotionName:        WideString  read FPromotionName write FPromotionName;
    property PromotionDescription: WideString  read FPromotionDescription write FPromotionDescription;
    property PromotionKey:         WideString  read FPromotionKey write FPromotionKey;
    property PromotionUnitPrice:   Single      read FPromotionUnitPrice write FPromotionUnitPrice;
  end;



  // ************************************************************************ //
  // XML       : clsIsMemberResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsMemberResponseData = class(TRemotable)
  private
    FIsAppraisalWorldMember: WideString;
    FAppraiserID: Integer;
    FCustomerID: Integer;
  published
    property IsAppraisalWorldMember: WideString  read FIsAppraisalWorldMember write FIsAppraisalWorldMember;
    property AppraiserID:            Integer     read FAppraiserID write FAppraiserID;
    property CustomerID:             Integer     read FCustomerID write FCustomerID;
  end;



  // ************************************************************************ //
  // XML       : clsIsMemberResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsMemberResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsIsMemberResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults               read FResults write FResults;
    property ResponseData: clsIsMemberResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetMemberInformationResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMemberInformationResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetMemberInformationData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsGetMemberInformationData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetMemberInformationData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMemberInformationData = class(TRemotable)
  private
    FIsPermanent: Integer;
    FFirstName: WideString;
    FLastName: WideString;
    FCompanyName: WideString;
    FAddress1: WideString;
    FAddress2: WideString;
    FCity: WideString;
    FState: WideString;
    FZipcode: WideString;
    FPhone: WideString;
    FEmail: WideString;
    FCellPhone: WideString;
  published
    property IsPermanent: Integer     read FIsPermanent write FIsPermanent;
    property FirstName:   WideString  read FFirstName write FFirstName;
    property LastName:    WideString  read FLastName write FLastName;
    property CompanyName: WideString  read FCompanyName write FCompanyName;
    property Address1:    WideString  read FAddress1 write FAddress1;
    property Address2:    WideString  read FAddress2 write FAddress2;
    property City:        WideString  read FCity write FCity;
    property State:       WideString  read FState write FState;
    property Zipcode:     WideString  read FZipcode write FZipcode;
    property Phone:       WideString  read FPhone write FPhone;
    property Email:       WideString  read FEmail write FEmail;
    property CellPhone:   WideString  read FCellPhone write FCellPhone;
  end;



  // ************************************************************************ //
  // XML       : clsLicenseItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsLicenseItem = class(TRemotable)
  private
    FLicenseNumber: WideString;
    FLicenseState: WideString;
    FLicenseExpireDate: WideString;
    FLicenseType: WideString;
    FLicenseLastValidationDate: WideString;
    FLicenseStatus: WideString;
  published
    property LicenseNumber:             WideString  read FLicenseNumber write FLicenseNumber;
    property LicenseState:              WideString  read FLicenseState write FLicenseState;
    property LicenseExpireDate:         WideString  read FLicenseExpireDate write FLicenseExpireDate;
    property LicenseType:               WideString  read FLicenseType write FLicenseType;
    property LicenseLastValidationDate: WideString  read FLicenseLastValidationDate write FLicenseLastValidationDate;
    property LicenseStatus:             WideString  read FLicenseStatus write FLicenseStatus;
  end;

  clsLicenseItemArray = array of clsLicenseItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGetMemberInformation2Data, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMemberInformation2Data = class(TRemotable)
  private
    FIsExtraUser: Integer;
    FFirstName: WideString;
    FLastName: WideString;
    FCompanyName: WideString;
    FAddress1: WideString;
    FAddress2: WideString;
    FCity: WideString;
    FState: WideString;
    FZipcode: WideString;
    FPhone: WideString;
    FEmail: WideString;
    FCellPhone: WideString;
    FUpdated: WideString;
    FLicenses: clsLicenseItemArray;
  public
    destructor Destroy; override;
  published
    property IsExtraUser: Integer              read FIsExtraUser write FIsExtraUser;
    property FirstName:   WideString           read FFirstName write FFirstName;
    property LastName:    WideString           read FLastName write FLastName;
    property CompanyName: WideString           read FCompanyName write FCompanyName;
    property Address1:    WideString           read FAddress1 write FAddress1;
    property Address2:    WideString           read FAddress2 write FAddress2;
    property City:        WideString           read FCity write FCity;
    property State:       WideString           read FState write FState;
    property Zipcode:     WideString           read FZipcode write FZipcode;
    property Phone:       WideString           read FPhone write FPhone;
    property Email:       WideString           read FEmail write FEmail;
    property CellPhone:   WideString           read FCellPhone write FCellPhone;
    property Updated:     WideString           read FUpdated write FUpdated;
    property Licenses:    clsLicenseItemArray  read FLicenses write FLicenses;
  end;



  // ************************************************************************ //
  // XML       : clsGetMemberInformation2Response, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMemberInformation2Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetMemberInformation2Data;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                    read FResults write FResults;
    property ResponseData: clsGetMemberInformation2Data  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsSendMessageResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSendMessageResponse = class(TRemotable)
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
  // XML       : clsSendExternalEmailResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSendExternalEmailResponse = class(TRemotable)
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
  // XML       : clsGetClickformsSecurityTokenResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClickformsSecurityTokenResponseData = class(TRemotable)
  private
    FSecurityToken: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
  published
    property SecurityToken:  WideString  read FSecurityToken write FSecurityToken;
    property CompanyKey:     WideString  read FCompanyKey write FCompanyKey;
    property OrderNumberKey: WideString  read FOrderNumberKey write FOrderNumberKey;
  end;



  // ************************************************************************ //
  // XML       : clsGetClickformsSecurityTokenResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClickformsSecurityTokenResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetClickformsSecurityTokenResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                                 read FResults write FResults;
    property ResponseData: clsGetClickformsSecurityTokenResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAttachmentListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAttachmentListItem = class(TRemotable)
  private
    FFilename: WideString;
    FData: WideString;
  published
    property Filename: WideString  read FFilename write FFilename;
    property Data:     WideString  read FData write FData;
  end;

  clsAttachmentList = array of clsAttachmentListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsToListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsToListItem = class(TRemotable)
  private
    FName_: WideString;
    FAddress: WideString;
  published
    property Name_:   WideString  read FName_ write FName_;
    property Address: WideString  read FAddress write FAddress;
  end;

  clsToList  = array of clsToListItem;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsAccessCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAccessCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsAwsiOrderDetailsRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAwsiOrderDetailsRequest = class(TRemotable)
  private
    FCompanyKey: WideString;
    FOrderNumber: WideString;
  published
    property CompanyKey:  WideString  read FCompanyKey write FCompanyKey;
    property OrderNumber: WideString  read FOrderNumber write FOrderNumber;
  end;



  // ************************************************************************ //
  // XML       : clsAddressDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddressDetails = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
  end;



  // ************************************************************************ //
  // XML       : clsNewOrderDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsNewOrderDetails = class(TRemotable)
  private
    FAppraiserOrderRef: WideString;
    FAppraiserOrderRef_Specified: boolean;
    FOrderRef: WideString;
    FOrderRef_Specified: boolean;
    FLenderOrderRef: WideString;
    FLenderOrderRef_Specified: boolean;
    procedure SetAppraiserOrderRef(Index: Integer; const AWideString: WideString);
    function  AppraiserOrderRef_Specified(Index: Integer): boolean;
    procedure SetOrderRef(Index: Integer; const AWideString: WideString);
    function  OrderRef_Specified(Index: Integer): boolean;
    procedure SetLenderOrderRef(Index: Integer; const AWideString: WideString);
    function  LenderOrderRef_Specified(Index: Integer): boolean;
  published
    property AppraiserOrderRef: WideString  Index (IS_OPTN) read FAppraiserOrderRef write SetAppraiserOrderRef stored AppraiserOrderRef_Specified;
    property OrderRef:          WideString  Index (IS_OPTN) read FOrderRef write SetOrderRef stored OrderRef_Specified;
    property LenderOrderRef:    WideString  Index (IS_OPTN) read FLenderOrderRef write SetLenderOrderRef stored LenderOrderRef_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsMemberInformationCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMemberInformationCredentials = class(TRemotable)
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
  // XML       : clsAcknowledgement, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer  read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // XML       : clsGetClientVersionRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClientVersionRequest = class(TRemotable)
  private
    FClientAppName: WideString;
  published
    property ClientAppName: WideString  read FClientAppName write FClientAppName;
  end;



  // ************************************************************************ //
  // XML       : clsAwsiNewOrderDetailsRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAwsiNewOrderDetailsRequest = class(TRemotable)
  private
    FCompanyKey: WideString;
    FAddressDetails: clsAddressDetails;
    FOrderDetails: clsNewOrderDetails;
    FOrderDetails_Specified: boolean;
    FProductKey: WideString;
    FWsiOrderNumber: WideString;
    FWsiOrderNumber_Specified: boolean;
    procedure SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
    function  OrderDetails_Specified(Index: Integer): boolean;
    procedure SetWsiOrderNumber(Index: Integer; const AWideString: WideString);
    function  WsiOrderNumber_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CompanyKey:     WideString          read FCompanyKey write FCompanyKey;
    property AddressDetails: clsAddressDetails   read FAddressDetails write FAddressDetails;
    property OrderDetails:   clsNewOrderDetails  Index (IS_OPTN) read FOrderDetails write SetOrderDetails stored OrderDetails_Specified;
    property ProductKey:     WideString          read FProductKey write FProductKey;
    property WsiOrderNumber: WideString          Index (IS_OPTN) read FWsiOrderNumber write SetWsiOrderNumber stored WsiOrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsAwsiNewOrder2DetailsRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAwsiNewOrder2DetailsRequest = class(TRemotable)
  private
    FCompanyKey: WideString;
    FAddressDetails: clsAddressDetails;
    FOrderDetails: clsNewOrderDetails;
    FOrderDetails_Specified: boolean;
    FProductKey: WideString;
    procedure SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
    function  OrderDetails_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CompanyKey:     WideString          read FCompanyKey write FCompanyKey;
    property AddressDetails: clsAddressDetails   read FAddressDetails write FAddressDetails;
    property OrderDetails:   clsNewOrderDetails  Index (IS_OPTN) read FOrderDetails write SetOrderDetails stored OrderDetails_Specified;
    property ProductKey:     WideString          read FProductKey write FProductKey;
  end;



  // ************************************************************************ //
  // XML       : clsAwsiNewOrder3DetailsRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAwsiNewOrder3DetailsRequest = class(TRemotable)
  private
    FCompanyKey: WideString;
    FAddressDetails: clsAddressDetails;
    FOrderDetails: clsNewOrderDetails;
    FOrderDetails_Specified: boolean;
    FProductKey: WideString;
    FProductKey_Specified: boolean;
    FCallingApp: WideString;
    FCallingApp_Specified: boolean;
    FReportCategoryId: Integer;
    FReportCategoryId_Specified: boolean;
    FReportId: Integer;
    FReportId_Specified: boolean;
    procedure SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
    function  OrderDetails_Specified(Index: Integer): boolean;
    procedure SetProductKey(Index: Integer; const AWideString: WideString);
    function  ProductKey_Specified(Index: Integer): boolean;
    procedure SetCallingApp(Index: Integer; const AWideString: WideString);
    function  CallingApp_Specified(Index: Integer): boolean;
    procedure SetReportCategoryId(Index: Integer; const AInteger: Integer);
    function  ReportCategoryId_Specified(Index: Integer): boolean;
    procedure SetReportId(Index: Integer; const AInteger: Integer);
    function  ReportId_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property CompanyKey:       WideString          read FCompanyKey write FCompanyKey;
    property AddressDetails:   clsAddressDetails   read FAddressDetails write FAddressDetails;
    property OrderDetails:     clsNewOrderDetails  Index (IS_OPTN) read FOrderDetails write SetOrderDetails stored OrderDetails_Specified;
    property ProductKey:       WideString          Index (IS_OPTN) read FProductKey write SetProductKey stored ProductKey_Specified;
    property CallingApp:       WideString          Index (IS_OPTN) read FCallingApp write SetCallingApp stored CallingApp_Specified;
    property ReportCategoryId: Integer             Index (IS_OPTN) read FReportCategoryId write SetReportCategoryId stored ReportCategoryId_Specified;
    property ReportId:         Integer             Index (IS_OPTN) read FReportId write SetReportId stored ReportId_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsLenderReferenceDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsLenderReferenceDetails = class(TRemotable)
  private
    FOrderNumberKey: WideString;
    FLenderName: WideString;
    FAddress: WideString;
    FAddress_Specified: boolean;
    FCity: WideString;
    FCity_Specified: boolean;
    FState: WideString;
    FState_Specified: boolean;
    FZipcode: WideString;
    FZipcode_Specified: boolean;
    FPhone: WideString;
    FPhone_Specified: boolean;
    FContact: WideString;
    FContact_Specified: boolean;
    FEmail: WideString;
    FEmail_Specified: boolean;
    FBranch: WideString;
    FBranch_Specified: boolean;
    FDepartment: WideString;
    FDepartment_Specified: boolean;
    procedure SetAddress(Index: Integer; const AWideString: WideString);
    function  Address_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const AWideString: WideString);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetZipcode(Index: Integer; const AWideString: WideString);
    function  Zipcode_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const AWideString: WideString);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetContact(Index: Integer; const AWideString: WideString);
    function  Contact_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const AWideString: WideString);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetBranch(Index: Integer; const AWideString: WideString);
    function  Branch_Specified(Index: Integer): boolean;
    procedure SetDepartment(Index: Integer; const AWideString: WideString);
    function  Department_Specified(Index: Integer): boolean;
  published
    property OrderNumberKey: WideString  read FOrderNumberKey write FOrderNumberKey;
    property LenderName:     WideString  read FLenderName write FLenderName;
    property Address:        WideString  Index (IS_OPTN) read FAddress write SetAddress stored Address_Specified;
    property City:           WideString  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:          WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zipcode:        WideString  Index (IS_OPTN) read FZipcode write SetZipcode stored Zipcode_Specified;
    property Phone:          WideString  Index (IS_OPTN) read FPhone write SetPhone stored Phone_Specified;
    property Contact:        WideString  Index (IS_OPTN) read FContact write SetContact stored Contact_Specified;
    property Email:          WideString  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property Branch:         WideString  Index (IS_OPTN) read FBranch write SetBranch stored Branch_Specified;
    property Department:     WideString  Index (IS_OPTN) read FDepartment write SetDepartment stored Department_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsAwsiAccessDetailsRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAwsiAccessDetailsRequest = class(TRemotable)
  private
    FCompanyKey: WideString;
    FOrderNumber: WideString;
  published
    property CompanyKey:  WideString  read FCompanyKey write FCompanyKey;
    property OrderNumber: WideString  read FOrderNumber write FOrderNumber;
  end;



  // ************************************************************************ //
  // XML       : clsIsMemberCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsMemberCredentials = class(TRemotable)
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
  // XML       : clsGetMemberInformationCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMemberInformationCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsSendMessageCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSendMessageCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsSendMessageRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSendMessageRequest = class(TRemotable)
  private
    FFrom: WideString;
    FToList: clsToList;
    FMessageText: WideString;
    FSubjectText: WideString;
    FAttachmentList: clsAttachmentList;
    FAttachmentList_Specified: boolean;
    procedure SetAttachmentList(Index: Integer; const AclsAttachmentList: clsAttachmentList);
    function  AttachmentList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property From:           WideString         read FFrom write FFrom;
    property ToList:         clsToList          read FToList write FToList;
    property MessageText:    WideString         read FMessageText write FMessageText;
    property SubjectText:    WideString         read FSubjectText write FSubjectText;
    property AttachmentList: clsAttachmentList  Index (IS_OPTN) read FAttachmentList write SetAttachmentList stored AttachmentList_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsSendExternalEmailRequest, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSendExternalEmailRequest = class(TRemotable)
  private
    FFrom: WideString;
    FToList: clsToList;
    FMessageText: WideString;
    FSubjectText: WideString;
    FAttachmentList: clsAttachmentList;
    FAttachmentList_Specified: boolean;
    procedure SetAttachmentList(Index: Integer; const AclsAttachmentList: clsAttachmentList);
    function  AttachmentList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property From:           WideString         read FFrom write FFrom;
    property ToList:         clsToList          read FToList write FToList;
    property MessageText:    WideString         read FMessageText write FMessageText;
    property SubjectText:    WideString         read FSubjectText write FSubjectText;
    property AttachmentList: clsAttachmentList  Index (IS_OPTN) read FAttachmentList write SetAttachmentList stored AttachmentList_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsUpdateMemberInformationData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUpdateMemberInformationData = class(TRemotable)
  private
    FFirstName: WideString;
    FFirstName_Specified: boolean;
    FLastName: WideString;
    FLastName_Specified: boolean;
    FCompanyName: WideString;
    FCompanyName_Specified: boolean;
    FAddress1: WideString;
    FAddress1_Specified: boolean;
    FAddress2: WideString;
    FAddress2_Specified: boolean;
    FCity: WideString;
    FCity_Specified: boolean;
    FState: WideString;
    FState_Specified: boolean;
    FZipcode: WideString;
    FZipcode_Specified: boolean;
    FPhone: WideString;
    FPhone_Specified: boolean;
    FEmail: WideString;
    FEmail_Specified: boolean;
    FCellPhone: WideString;
    FCellPhone_Specified: boolean;
    procedure SetFirstName(Index: Integer; const AWideString: WideString);
    function  FirstName_Specified(Index: Integer): boolean;
    procedure SetLastName(Index: Integer; const AWideString: WideString);
    function  LastName_Specified(Index: Integer): boolean;
    procedure SetCompanyName(Index: Integer; const AWideString: WideString);
    function  CompanyName_Specified(Index: Integer): boolean;
    procedure SetAddress1(Index: Integer; const AWideString: WideString);
    function  Address1_Specified(Index: Integer): boolean;
    procedure SetAddress2(Index: Integer; const AWideString: WideString);
    function  Address2_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const AWideString: WideString);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetZipcode(Index: Integer; const AWideString: WideString);
    function  Zipcode_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const AWideString: WideString);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const AWideString: WideString);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetCellPhone(Index: Integer; const AWideString: WideString);
    function  CellPhone_Specified(Index: Integer): boolean;
  published
    property FirstName:   WideString  Index (IS_OPTN) read FFirstName write SetFirstName stored FirstName_Specified;
    property LastName:    WideString  Index (IS_OPTN) read FLastName write SetLastName stored LastName_Specified;
    property CompanyName: WideString  Index (IS_OPTN) read FCompanyName write SetCompanyName stored CompanyName_Specified;
    property Address1:    WideString  Index (IS_OPTN) read FAddress1 write SetAddress1 stored Address1_Specified;
    property Address2:    WideString  Index (IS_OPTN) read FAddress2 write SetAddress2 stored Address2_Specified;
    property City:        WideString  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:       WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zipcode:     WideString  Index (IS_OPTN) read FZipcode write SetZipcode stored Zipcode_Specified;
    property Phone:       WideString  Index (IS_OPTN) read FPhone write SetPhone stored Phone_Specified;
    property Email:       WideString  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property CellPhone:   WideString  Index (IS_OPTN) read FCellPhone write SetCellPhone stored CellPhone_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsUpdateMemberInformationCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUpdateMemberInformationCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsSignatureUpdateDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsSignatureUpdateDetails = class(TRemotable)
  private
    FSignatureFullName: WideString;
    FSignatureFullName_Specified: boolean;
    FSignatureCompanyName: WideString;
    FSignatureCompanyName_Specified: boolean;
    FSignatureImage: WideString;
    FSignatureImage_Specified: boolean;
    FSignatureOffsetPoint: clsOffsetPoint;
    FSignatureDisplayRectangle: clsDisplayRectangle;
    procedure SetSignatureFullName(Index: Integer; const AWideString: WideString);
    function  SignatureFullName_Specified(Index: Integer): boolean;
    procedure SetSignatureCompanyName(Index: Integer; const AWideString: WideString);
    function  SignatureCompanyName_Specified(Index: Integer): boolean;
    procedure SetSignatureImage(Index: Integer; const AWideString: WideString);
    function  SignatureImage_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property SignatureFullName:         WideString           Index (IS_OPTN) read FSignatureFullName write SetSignatureFullName stored SignatureFullName_Specified;
    property SignatureCompanyName:      WideString           Index (IS_OPTN) read FSignatureCompanyName write SetSignatureCompanyName stored SignatureCompanyName_Specified;
    property SignatureImage:            WideString           Index (IS_OPTN) read FSignatureImage write SetSignatureImage stored SignatureImage_Specified;
    property SignatureOffsetPoint:      clsOffsetPoint       read FSignatureOffsetPoint write FSignatureOffsetPoint;
    property SignatureDisplayRectangle: clsDisplayRectangle  read FSignatureDisplayRectangle write FSignatureDisplayRectangle;
  end;



  // ************************************************************************ //
  // XML       : clsUpdateMemberInformation2Data, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUpdateMemberInformation2Data = class(TRemotable)
  private
    FFirstName: WideString;
    FFirstName_Specified: boolean;
    FLastName: WideString;
    FLastName_Specified: boolean;
    FCompanyName: WideString;
    FCompanyName_Specified: boolean;
    FAddress1: WideString;
    FAddress1_Specified: boolean;
    FAddress2: WideString;
    FAddress2_Specified: boolean;
    FCity: WideString;
    FCity_Specified: boolean;
    FState: WideString;
    FState_Specified: boolean;
    FZipcode: WideString;
    FZipcode_Specified: boolean;
    FPhone: WideString;
    FPhone_Specified: boolean;
    FEmail: WideString;
    FEmail_Specified: boolean;
    FCellPhone: WideString;
    FCellPhone_Specified: boolean;
    FSignatureDetails: clsSignatureUpdateDetails;
    FSignatureDetails_Specified: boolean;
    procedure SetFirstName(Index: Integer; const AWideString: WideString);
    function  FirstName_Specified(Index: Integer): boolean;
    procedure SetLastName(Index: Integer; const AWideString: WideString);
    function  LastName_Specified(Index: Integer): boolean;
    procedure SetCompanyName(Index: Integer; const AWideString: WideString);
    function  CompanyName_Specified(Index: Integer): boolean;
    procedure SetAddress1(Index: Integer; const AWideString: WideString);
    function  Address1_Specified(Index: Integer): boolean;
    procedure SetAddress2(Index: Integer; const AWideString: WideString);
    function  Address2_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const AWideString: WideString);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetZipcode(Index: Integer; const AWideString: WideString);
    function  Zipcode_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const AWideString: WideString);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const AWideString: WideString);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetCellPhone(Index: Integer; const AWideString: WideString);
    function  CellPhone_Specified(Index: Integer): boolean;
    procedure SetSignatureDetails(Index: Integer; const AclsSignatureUpdateDetails: clsSignatureUpdateDetails);
    function  SignatureDetails_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property FirstName:        WideString                 Index (IS_OPTN) read FFirstName write SetFirstName stored FirstName_Specified;
    property LastName:         WideString                 Index (IS_OPTN) read FLastName write SetLastName stored LastName_Specified;
    property CompanyName:      WideString                 Index (IS_OPTN) read FCompanyName write SetCompanyName stored CompanyName_Specified;
    property Address1:         WideString                 Index (IS_OPTN) read FAddress1 write SetAddress1 stored Address1_Specified;
    property Address2:         WideString                 Index (IS_OPTN) read FAddress2 write SetAddress2 stored Address2_Specified;
    property City:             WideString                 Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:            WideString                 Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zipcode:          WideString                 Index (IS_OPTN) read FZipcode write SetZipcode stored Zipcode_Specified;
    property Phone:            WideString                 Index (IS_OPTN) read FPhone write SetPhone stored Phone_Specified;
    property Email:            WideString                 Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property CellPhone:        WideString                 Index (IS_OPTN) read FCellPhone write SetCellPhone stored CellPhone_Specified;
    property SignatureDetails: clsSignatureUpdateDetails  Index (IS_OPTN) read FSignatureDetails write SetSignatureDetails stored SignatureDetails_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetClickformsSecurityTokenCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetClickformsSecurityTokenCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FUsername_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    FCustomerId: Integer;
    FCustomerId_Specified: boolean;
    procedure SetUsername(Index: Integer; const AWideString: WideString);
    function  Username_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetCustomerId(Index: Integer; const AInteger: Integer);
    function  CustomerId_Specified(Index: Integer): boolean;
  published
    property Username:   WideString  Index (IS_OPTN) read FUsername write SetUsername stored Username_Specified;
    property Password:   WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property CustomerId: Integer     Index (IS_OPTN) read FCustomerId write SetCustomerId stored CustomerId_Specified;
  end;

  key             = WideString;      { "http://carme.atbx.net/secure/ws/WSDL"[Alias] }
  ArrayOfString = array of key;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsOpenOrderListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsOpenOrderListItem = class(TRemotable)
  private
    FOrderNumber: WideString;
    FCompanyKey: WideString;
    FCompanyName: WideString;
    FCreateDate: WideString;
    FAppraiserRefNbr: WideString;
    FAmcRefNbr: WideString;
    FLenderRefNbr: WideString;
    FUnusedProducts: ArrayOfString;
  published
    property OrderNumber:     WideString     read FOrderNumber write FOrderNumber;
    property CompanyKey:      WideString     read FCompanyKey write FCompanyKey;
    property CompanyName:     WideString     read FCompanyName write FCompanyName;
    property CreateDate:      WideString     read FCreateDate write FCreateDate;
    property AppraiserRefNbr: WideString     read FAppraiserRefNbr write FAppraiserRefNbr;
    property AmcRefNbr:       WideString     read FAmcRefNbr write FAmcRefNbr;
    property LenderRefNbr:    WideString     read FLenderRefNbr write FLenderRefNbr;
    property UnusedProducts:  ArrayOfString  read FUnusedProducts write FUnusedProducts;
  end;



  // ************************************************************************ //
  // XML       : clsCompanyListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCompanyListItem = class(TRemotable)
  private
    FCompanyName: WideString;
    FCompanyKey: WideString;
    FDemoState: Integer;
    FDemoState_Specified: boolean;
    FSpecialServices: ArrayOfString;
    FSpecialServices_Specified: boolean;
    procedure SetDemoState(Index: Integer; const AInteger: Integer);
    function  DemoState_Specified(Index: Integer): boolean;
    procedure SetSpecialServices(Index: Integer; const AArrayOfString: ArrayOfString);
    function  SpecialServices_Specified(Index: Integer): boolean;
  published
    property CompanyName:     WideString     read FCompanyName write FCompanyName;
    property CompanyKey:      WideString     read FCompanyKey write FCompanyKey;
    property DemoState:       Integer        Index (IS_OPTN) read FDemoState write SetDemoState stored DemoState_Specified;
    property SpecialServices: ArrayOfString  Index (IS_OPTN) read FSpecialServices write SetSpecialServices stored SpecialServices_Specified;
  end;


  // ************************************************************************ //
  // Namespace : AwsiAccessServerClass
  // soapAction: AwsiAccessServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : AwsiAccessServerBinding
  // service   : AwsiAccessServer
  // port      : AwsiAccessServerPort
  // URL       : http://carme.atbx.net/secure/ws/awsi/AwsiAccessServer.php
  // ************************************************************************ //
  AwsiAccessServerPortType = interface(IInvokable)
  ['{34C75561-F281-9012-BD56-393AE858DD5E}']
    function  AwsiAccessService_GetClickformsSecurityToken(const AccessCredentials: clsGetClickformsSecurityTokenCredentials): clsGetClickformsSecurityTokenResponse; stdcall;
    function  AwsiAccessService_Acknowledgement(const AccessCredentials: clsAccessCredentials; const AwsiAccessAcknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
    function  AwsiAccessService_GetClientVersion(const Client: clsGetClientVersionRequest): clsGetClientVersionResponse; stdcall;
    function  AwsiAccessService_GetNewOrder(const AccessCredentials: clsAccessCredentials; const AwsiAccessDetail: clsAwsiNewOrderDetailsRequest): clsGetNewOrderResponse; stdcall;
    function  AwsiAccessService_GetNewOrder2(const AccessCredentials: clsAccessCredentials; const AwsiAccessDetail: clsAwsiNewOrder2DetailsRequest): clsGetNewOrder2Response; stdcall;
    function  AwsiAccessService_GetNewOrder3(const AccessCredentials: clsAccessCredentials; const AwsiAccessDetail: clsAwsiNewOrder3DetailsRequest): clsGetNewOrder3Response; stdcall;
    function  AwsiAccessService_GetExistingOrder(const AccessCredentials: clsAccessCredentials; const AwsiAccessDetail: clsAwsiOrderDetailsRequest): clsGetExistingOrderResponse; stdcall;
    function  AwsiAccessService_AddLenderReference(const AccessCredentials: clsAccessCredentials; const LenderReferenceDetails: clsLenderReferenceDetails): clsAddLenderReferenceResponse; stdcall;
    function  AwsiAccessService_GetMemberInformation(const MemberAccessCredentials: clsGetMemberInformationCredentials): clsGetMemberInformationResponse; stdcall;
    function  AwsiAccessService_GetMemberInformation2(const MemberAccessCredentials: clsMemberInformationCredentials): clsGetMemberInformation2Response; stdcall;
    function  AwsiAccessService_GetSecurityToken(const AccessCredentials: clsAccessCredentials; const AwsiAccessDetail: clsAwsiAccessDetailsRequest): clsGetSecurityTokenResponse; stdcall;
    function  AwsiAccessService_GetSignatureLastChangeDate(const MemberAccessCredentials: clsMemberInformationCredentials): clsGetSignatureLastChangeDateResponse; stdcall;
    function  AwsiAccessService_GetSignatureDetails(const MemberAccessCredentials: clsMemberInformationCredentials): clsGetSignatureDetailsResponse; stdcall;
    function  AwsiAccessService_InitializeConnection(const AccessCredentials: clsAccessCredentials): clsInitializeConnectionResponse; stdcall;
    function  AwsiAccessService_IsMember(const IsMemberCredentials: clsIsMemberCredentials): clsIsMemberResponse; stdcall;
    function  AwsiAccessService_SendExternalEmail(const MessageDetails: clsSendExternalEmailRequest): clsSendExternalEmailResponse; stdcall;
    function  AwsiAccessService_SendMessage(const MemberAccessCredentials: clsSendMessageCredentials; const MessageDetails: clsSendMessageRequest): clsSendMessageResponse; stdcall;
    function  AwsiAccessService_UpdateMemberInformation2(const MemberAccessCredentials: clsMemberInformationCredentials; const MemberInformation2Details: clsUpdateMemberInformation2Data): clsUpdateMemberInformationResponse; stdcall;
    function  AwsiAccessService_UpdateMemberInformation(const MemberAccessCredentials: clsUpdateMemberInformationCredentials; const MemberInformationDetails: clsUpdateMemberInformationData): clsUpdateMemberInformationResponse; stdcall;
  end;

function GetAwsiAccessServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AwsiAccessServerPortType;


implementation
  uses SysUtils;

function GetAwsiAccessServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AwsiAccessServerPortType;
const
  defWSDL = 'C:\temp\AwsiAccessServer_php.wsdl';
  defURL  = 'http://carme.atbx.net/secure/ws/awsi/AwsiAccessServer.php';
  defSvc  = 'AwsiAccessServer';
  defPrt  = 'AwsiAccessServerPort';
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
    Result := (RIO as AwsiAccessServerPortType);
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


procedure clsGetExistingOrderData.SetOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FOrderNumber := AWideString;
  FOrderNumber_Specified := True;
end;

function clsGetExistingOrderData.OrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FOrderNumber_Specified;
end;

destructor clsUpdateMemberInformationResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsAcknowledgementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetClientVersionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetNewOrderResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsGetOrder2Data.SetOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FOrderNumber := AWideString;
  FOrderNumber_Specified := True;
end;

function clsGetOrder2Data.OrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FOrderNumber_Specified;
end;

destructor clsGetNewOrder2Response.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsGetOrder3Data.SetOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FOrderNumber := AWideString;
  FOrderNumber_Specified := True;
end;

function clsGetOrder3Data.OrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FOrderNumber_Specified;
end;

destructor clsGetNewOrder3Response.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetExistingOrderResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsAddLenderReferenceResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsGetSecurityTokenResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetSignatureDetailsData.Destroy;
begin
  FreeAndNil(FSignatureOffsetPoint);
  FreeAndNil(FSignatureDisplayRectangle);
  inherited Destroy;
end;

destructor clsGetSignatureDetailsResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetSignatureLastChangeDateResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsInitializeConnectionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsInitializeConnectionData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FCompanyList)-1 do
    FreeAndNil(FCompanyList[I]);
  SetLength(FCompanyList, 0);
  for I := 0 to Length(FProductList)-1 do
    FreeAndNil(FProductList[I]);
  SetLength(FProductList, 0);
  for I := 0 to Length(FOpenOrderList)-1 do
    FreeAndNil(FOpenOrderList[I]);
  SetLength(FOpenOrderList, 0);
  for I := 0 to Length(FPromotionList)-1 do
    FreeAndNil(FPromotionList[I]);
  SetLength(FPromotionList, 0);
  inherited Destroy;
end;

procedure clsInitializeConnectionData.SetOpenOrderList(Index: Integer; const AclsOpenOrderList: clsOpenOrderList);
begin
  FOpenOrderList := AclsOpenOrderList;
  FOpenOrderList_Specified := True;
end;

function clsInitializeConnectionData.OpenOrderList_Specified(Index: Integer): boolean;
begin
  Result := FOpenOrderList_Specified;
end;

procedure clsInitializeConnectionData.SetPromotionList(Index: Integer; const AclsPromotionList: clsPromotionList);
begin
  FPromotionList := AclsPromotionList;
  FPromotionList_Specified := True;
end;

function clsInitializeConnectionData.PromotionList_Specified(Index: Integer): boolean;
begin
  Result := FPromotionList_Specified;
end;

destructor clsIsMemberResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetMemberInformationResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetMemberInformation2Data.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLicenses)-1 do
    FreeAndNil(FLicenses[I]);
  SetLength(FLicenses, 0);
  inherited Destroy;
end;

destructor clsGetMemberInformation2Response.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsSendMessageResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsSendExternalEmailResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsGetClickformsSecurityTokenResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsNewOrderDetails.SetAppraiserOrderRef(Index: Integer; const AWideString: WideString);
begin
  FAppraiserOrderRef := AWideString;
  FAppraiserOrderRef_Specified := True;
end;

function clsNewOrderDetails.AppraiserOrderRef_Specified(Index: Integer): boolean;
begin
  Result := FAppraiserOrderRef_Specified;
end;

procedure clsNewOrderDetails.SetOrderRef(Index: Integer; const AWideString: WideString);
begin
  FOrderRef := AWideString;
  FOrderRef_Specified := True;
end;

function clsNewOrderDetails.OrderRef_Specified(Index: Integer): boolean;
begin
  Result := FOrderRef_Specified;
end;

procedure clsNewOrderDetails.SetLenderOrderRef(Index: Integer; const AWideString: WideString);
begin
  FLenderOrderRef := AWideString;
  FLenderOrderRef_Specified := True;
end;

function clsNewOrderDetails.LenderOrderRef_Specified(Index: Integer): boolean;
begin
  Result := FLenderOrderRef_Specified;
end;

destructor clsAwsiNewOrderDetailsRequest.Destroy;
begin
  FreeAndNil(FAddressDetails);
  FreeAndNil(FOrderDetails);
  inherited Destroy;
end;

procedure clsAwsiNewOrderDetailsRequest.SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
begin
  FOrderDetails := AclsNewOrderDetails;
  FOrderDetails_Specified := True;
end;

function clsAwsiNewOrderDetailsRequest.OrderDetails_Specified(Index: Integer): boolean;
begin
  Result := FOrderDetails_Specified;
end;

procedure clsAwsiNewOrderDetailsRequest.SetWsiOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FWsiOrderNumber := AWideString;
  FWsiOrderNumber_Specified := True;
end;

function clsAwsiNewOrderDetailsRequest.WsiOrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FWsiOrderNumber_Specified;
end;

destructor clsAwsiNewOrder2DetailsRequest.Destroy;
begin
  FreeAndNil(FAddressDetails);
  FreeAndNil(FOrderDetails);
  inherited Destroy;
end;

procedure clsAwsiNewOrder2DetailsRequest.SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
begin
  FOrderDetails := AclsNewOrderDetails;
  FOrderDetails_Specified := True;
end;

function clsAwsiNewOrder2DetailsRequest.OrderDetails_Specified(Index: Integer): boolean;
begin
  Result := FOrderDetails_Specified;
end;

destructor clsAwsiNewOrder3DetailsRequest.Destroy;
begin
  FreeAndNil(FAddressDetails);
  FreeAndNil(FOrderDetails);
  inherited Destroy;
end;

procedure clsAwsiNewOrder3DetailsRequest.SetOrderDetails(Index: Integer; const AclsNewOrderDetails: clsNewOrderDetails);
begin
  FOrderDetails := AclsNewOrderDetails;
  FOrderDetails_Specified := True;
end;

function clsAwsiNewOrder3DetailsRequest.OrderDetails_Specified(Index: Integer): boolean;
begin
  Result := FOrderDetails_Specified;
end;

procedure clsAwsiNewOrder3DetailsRequest.SetProductKey(Index: Integer; const AWideString: WideString);
begin
  FProductKey := AWideString;
  FProductKey_Specified := True;
end;

function clsAwsiNewOrder3DetailsRequest.ProductKey_Specified(Index: Integer): boolean;
begin
  Result := FProductKey_Specified;
end;

procedure clsAwsiNewOrder3DetailsRequest.SetCallingApp(Index: Integer; const AWideString: WideString);
begin
  FCallingApp := AWideString;
  FCallingApp_Specified := True;
end;

function clsAwsiNewOrder3DetailsRequest.CallingApp_Specified(Index: Integer): boolean;
begin
  Result := FCallingApp_Specified;
end;

procedure clsAwsiNewOrder3DetailsRequest.SetReportCategoryId(Index: Integer; const AInteger: Integer);
begin
  FReportCategoryId := AInteger;
  FReportCategoryId_Specified := True;
end;

function clsAwsiNewOrder3DetailsRequest.ReportCategoryId_Specified(Index: Integer): boolean;
begin
  Result := FReportCategoryId_Specified;
end;

procedure clsAwsiNewOrder3DetailsRequest.SetReportId(Index: Integer; const AInteger: Integer);
begin
  FReportId := AInteger;
  FReportId_Specified := True;
end;

function clsAwsiNewOrder3DetailsRequest.ReportId_Specified(Index: Integer): boolean;
begin
  Result := FReportId_Specified;
end;

procedure clsLenderReferenceDetails.SetAddress(Index: Integer; const AWideString: WideString);
begin
  FAddress := AWideString;
  FAddress_Specified := True;
end;

function clsLenderReferenceDetails.Address_Specified(Index: Integer): boolean;
begin
  Result := FAddress_Specified;
end;

procedure clsLenderReferenceDetails.SetCity(Index: Integer; const AWideString: WideString);
begin
  FCity := AWideString;
  FCity_Specified := True;
end;

function clsLenderReferenceDetails.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure clsLenderReferenceDetails.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsLenderReferenceDetails.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsLenderReferenceDetails.SetZipcode(Index: Integer; const AWideString: WideString);
begin
  FZipcode := AWideString;
  FZipcode_Specified := True;
end;

function clsLenderReferenceDetails.Zipcode_Specified(Index: Integer): boolean;
begin
  Result := FZipcode_Specified;
end;

procedure clsLenderReferenceDetails.SetPhone(Index: Integer; const AWideString: WideString);
begin
  FPhone := AWideString;
  FPhone_Specified := True;
end;

function clsLenderReferenceDetails.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure clsLenderReferenceDetails.SetContact(Index: Integer; const AWideString: WideString);
begin
  FContact := AWideString;
  FContact_Specified := True;
end;

function clsLenderReferenceDetails.Contact_Specified(Index: Integer): boolean;
begin
  Result := FContact_Specified;
end;

procedure clsLenderReferenceDetails.SetEmail(Index: Integer; const AWideString: WideString);
begin
  FEmail := AWideString;
  FEmail_Specified := True;
end;

function clsLenderReferenceDetails.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure clsLenderReferenceDetails.SetBranch(Index: Integer; const AWideString: WideString);
begin
  FBranch := AWideString;
  FBranch_Specified := True;
end;

function clsLenderReferenceDetails.Branch_Specified(Index: Integer): boolean;
begin
  Result := FBranch_Specified;
end;

procedure clsLenderReferenceDetails.SetDepartment(Index: Integer; const AWideString: WideString);
begin
  FDepartment := AWideString;
  FDepartment_Specified := True;
end;

function clsLenderReferenceDetails.Department_Specified(Index: Integer): boolean;
begin
  Result := FDepartment_Specified;
end;

destructor clsSendMessageRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FToList)-1 do
    FreeAndNil(FToList[I]);
  SetLength(FToList, 0);
  for I := 0 to Length(FAttachmentList)-1 do
    FreeAndNil(FAttachmentList[I]);
  SetLength(FAttachmentList, 0);
  inherited Destroy;
end;

procedure clsSendMessageRequest.SetAttachmentList(Index: Integer; const AclsAttachmentList: clsAttachmentList);
begin
  FAttachmentList := AclsAttachmentList;
  FAttachmentList_Specified := True;
end;

function clsSendMessageRequest.AttachmentList_Specified(Index: Integer): boolean;
begin
  Result := FAttachmentList_Specified;
end;

destructor clsSendExternalEmailRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FToList)-1 do
    FreeAndNil(FToList[I]);
  SetLength(FToList, 0);
  for I := 0 to Length(FAttachmentList)-1 do
    FreeAndNil(FAttachmentList[I]);
  SetLength(FAttachmentList, 0);
  inherited Destroy;
end;

procedure clsSendExternalEmailRequest.SetAttachmentList(Index: Integer; const AclsAttachmentList: clsAttachmentList);
begin
  FAttachmentList := AclsAttachmentList;
  FAttachmentList_Specified := True;
end;

function clsSendExternalEmailRequest.AttachmentList_Specified(Index: Integer): boolean;
begin
  Result := FAttachmentList_Specified;
end;

procedure clsUpdateMemberInformationData.SetFirstName(Index: Integer; const AWideString: WideString);
begin
  FFirstName := AWideString;
  FFirstName_Specified := True;
end;

function clsUpdateMemberInformationData.FirstName_Specified(Index: Integer): boolean;
begin
  Result := FFirstName_Specified;
end;

procedure clsUpdateMemberInformationData.SetLastName(Index: Integer; const AWideString: WideString);
begin
  FLastName := AWideString;
  FLastName_Specified := True;
end;

function clsUpdateMemberInformationData.LastName_Specified(Index: Integer): boolean;
begin
  Result := FLastName_Specified;
end;

procedure clsUpdateMemberInformationData.SetCompanyName(Index: Integer; const AWideString: WideString);
begin
  FCompanyName := AWideString;
  FCompanyName_Specified := True;
end;

function clsUpdateMemberInformationData.CompanyName_Specified(Index: Integer): boolean;
begin
  Result := FCompanyName_Specified;
end;

procedure clsUpdateMemberInformationData.SetAddress1(Index: Integer; const AWideString: WideString);
begin
  FAddress1 := AWideString;
  FAddress1_Specified := True;
end;

function clsUpdateMemberInformationData.Address1_Specified(Index: Integer): boolean;
begin
  Result := FAddress1_Specified;
end;

procedure clsUpdateMemberInformationData.SetAddress2(Index: Integer; const AWideString: WideString);
begin
  FAddress2 := AWideString;
  FAddress2_Specified := True;
end;

function clsUpdateMemberInformationData.Address2_Specified(Index: Integer): boolean;
begin
  Result := FAddress2_Specified;
end;

procedure clsUpdateMemberInformationData.SetCity(Index: Integer; const AWideString: WideString);
begin
  FCity := AWideString;
  FCity_Specified := True;
end;

function clsUpdateMemberInformationData.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure clsUpdateMemberInformationData.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsUpdateMemberInformationData.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsUpdateMemberInformationData.SetZipcode(Index: Integer; const AWideString: WideString);
begin
  FZipcode := AWideString;
  FZipcode_Specified := True;
end;

function clsUpdateMemberInformationData.Zipcode_Specified(Index: Integer): boolean;
begin
  Result := FZipcode_Specified;
end;

procedure clsUpdateMemberInformationData.SetPhone(Index: Integer; const AWideString: WideString);
begin
  FPhone := AWideString;
  FPhone_Specified := True;
end;

function clsUpdateMemberInformationData.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure clsUpdateMemberInformationData.SetEmail(Index: Integer; const AWideString: WideString);
begin
  FEmail := AWideString;
  FEmail_Specified := True;
end;

function clsUpdateMemberInformationData.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure clsUpdateMemberInformationData.SetCellPhone(Index: Integer; const AWideString: WideString);
begin
  FCellPhone := AWideString;
  FCellPhone_Specified := True;
end;

function clsUpdateMemberInformationData.CellPhone_Specified(Index: Integer): boolean;
begin
  Result := FCellPhone_Specified;
end;

destructor clsSignatureUpdateDetails.Destroy;
begin
  FreeAndNil(FSignatureOffsetPoint);
  FreeAndNil(FSignatureDisplayRectangle);
  inherited Destroy;
end;

procedure clsSignatureUpdateDetails.SetSignatureFullName(Index: Integer; const AWideString: WideString);
begin
  FSignatureFullName := AWideString;
  FSignatureFullName_Specified := True;
end;

function clsSignatureUpdateDetails.SignatureFullName_Specified(Index: Integer): boolean;
begin
  Result := FSignatureFullName_Specified;
end;

procedure clsSignatureUpdateDetails.SetSignatureCompanyName(Index: Integer; const AWideString: WideString);
begin
  FSignatureCompanyName := AWideString;
  FSignatureCompanyName_Specified := True;
end;

function clsSignatureUpdateDetails.SignatureCompanyName_Specified(Index: Integer): boolean;
begin
  Result := FSignatureCompanyName_Specified;
end;

procedure clsSignatureUpdateDetails.SetSignatureImage(Index: Integer; const AWideString: WideString);
begin
  FSignatureImage := AWideString;
  FSignatureImage_Specified := True;
end;

function clsSignatureUpdateDetails.SignatureImage_Specified(Index: Integer): boolean;
begin
  Result := FSignatureImage_Specified;
end;

destructor clsUpdateMemberInformation2Data.Destroy;
begin
  FreeAndNil(FSignatureDetails);
  inherited Destroy;
end;

procedure clsUpdateMemberInformation2Data.SetFirstName(Index: Integer; const AWideString: WideString);
begin
  FFirstName := AWideString;
  FFirstName_Specified := True;
end;

function clsUpdateMemberInformation2Data.FirstName_Specified(Index: Integer): boolean;
begin
  Result := FFirstName_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetLastName(Index: Integer; const AWideString: WideString);
begin
  FLastName := AWideString;
  FLastName_Specified := True;
end;

function clsUpdateMemberInformation2Data.LastName_Specified(Index: Integer): boolean;
begin
  Result := FLastName_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetCompanyName(Index: Integer; const AWideString: WideString);
begin
  FCompanyName := AWideString;
  FCompanyName_Specified := True;
end;

function clsUpdateMemberInformation2Data.CompanyName_Specified(Index: Integer): boolean;
begin
  Result := FCompanyName_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetAddress1(Index: Integer; const AWideString: WideString);
begin
  FAddress1 := AWideString;
  FAddress1_Specified := True;
end;

function clsUpdateMemberInformation2Data.Address1_Specified(Index: Integer): boolean;
begin
  Result := FAddress1_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetAddress2(Index: Integer; const AWideString: WideString);
begin
  FAddress2 := AWideString;
  FAddress2_Specified := True;
end;

function clsUpdateMemberInformation2Data.Address2_Specified(Index: Integer): boolean;
begin
  Result := FAddress2_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetCity(Index: Integer; const AWideString: WideString);
begin
  FCity := AWideString;
  FCity_Specified := True;
end;

function clsUpdateMemberInformation2Data.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsUpdateMemberInformation2Data.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetZipcode(Index: Integer; const AWideString: WideString);
begin
  FZipcode := AWideString;
  FZipcode_Specified := True;
end;

function clsUpdateMemberInformation2Data.Zipcode_Specified(Index: Integer): boolean;
begin
  Result := FZipcode_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetPhone(Index: Integer; const AWideString: WideString);
begin
  FPhone := AWideString;
  FPhone_Specified := True;
end;

function clsUpdateMemberInformation2Data.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetEmail(Index: Integer; const AWideString: WideString);
begin
  FEmail := AWideString;
  FEmail_Specified := True;
end;

function clsUpdateMemberInformation2Data.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetCellPhone(Index: Integer; const AWideString: WideString);
begin
  FCellPhone := AWideString;
  FCellPhone_Specified := True;
end;

function clsUpdateMemberInformation2Data.CellPhone_Specified(Index: Integer): boolean;
begin
  Result := FCellPhone_Specified;
end;

procedure clsUpdateMemberInformation2Data.SetSignatureDetails(Index: Integer; const AclsSignatureUpdateDetails: clsSignatureUpdateDetails);
begin
  FSignatureDetails := AclsSignatureUpdateDetails;
  FSignatureDetails_Specified := True;
end;

function clsUpdateMemberInformation2Data.SignatureDetails_Specified(Index: Integer): boolean;
begin
  Result := FSignatureDetails_Specified;
end;

procedure clsGetClickformsSecurityTokenCredentials.SetUsername(Index: Integer; const AWideString: WideString);
begin
  FUsername := AWideString;
  FUsername_Specified := True;
end;

function clsGetClickformsSecurityTokenCredentials.Username_Specified(Index: Integer): boolean;
begin
  Result := FUsername_Specified;
end;

procedure clsGetClickformsSecurityTokenCredentials.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function clsGetClickformsSecurityTokenCredentials.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure clsGetClickformsSecurityTokenCredentials.SetCustomerId(Index: Integer; const AInteger: Integer);
begin
  FCustomerId := AInteger;
  FCustomerId_Specified := True;
end;

function clsGetClickformsSecurityTokenCredentials.CustomerId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerId_Specified;
end;

procedure clsCompanyListItem.SetDemoState(Index: Integer; const AInteger: Integer);
begin
  FDemoState := AInteger;
  FDemoState_Specified := True;
end;

function clsCompanyListItem.DemoState_Specified(Index: Integer): boolean;
begin
  Result := FDemoState_Specified;
end;

procedure clsCompanyListItem.SetSpecialServices(Index: Integer; const AArrayOfString: ArrayOfString);
begin
  FSpecialServices := AArrayOfString;
  FSpecialServices_Specified := True;
end;

function clsCompanyListItem.SpecialServices_Specified(Index: Integer): boolean;
begin
  Result := FSpecialServices_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetClickformsSecurityToken', 'AwsiAccessService.GetClickformsSecurityToken');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_Acknowledgement', 'AwsiAccessService.Acknowledgement');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetClientVersion', 'AwsiAccessService.GetClientVersion');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetNewOrder', 'AwsiAccessService.GetNewOrder');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetNewOrder2', 'AwsiAccessService.GetNewOrder2');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetNewOrder3', 'AwsiAccessService.GetNewOrder3');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetExistingOrder', 'AwsiAccessService.GetExistingOrder');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_AddLenderReference', 'AwsiAccessService.AddLenderReference');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetMemberInformation', 'AwsiAccessService.GetMemberInformation');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetMemberInformation2', 'AwsiAccessService.GetMemberInformation2');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetSecurityToken', 'AwsiAccessService.GetSecurityToken');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetSignatureLastChangeDate', 'AwsiAccessService.GetSignatureLastChangeDate');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_GetSignatureDetails', 'AwsiAccessService.GetSignatureDetails');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_InitializeConnection', 'AwsiAccessService.InitializeConnection');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_IsMember', 'AwsiAccessService.IsMember');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_SendExternalEmail', 'AwsiAccessService.SendExternalEmail');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_SendMessage', 'AwsiAccessService.SendMessage');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_UpdateMemberInformation2', 'AwsiAccessService.UpdateMemberInformation2');
  InvRegistry.RegisterExternalMethName(TypeInfo(AwsiAccessServerPortType), 'AwsiAccessService_UpdateMemberInformation', 'AwsiAccessService.UpdateMemberInformation');
  RemClassRegistry.RegisterXSClass(clsOffsetPoint, 'http://carme.atbx.net/secure/ws/WSDL', 'clsOffsetPoint');
  RemClassRegistry.RegisterXSClass(clsDisplayRectangle, 'http://carme.atbx.net/secure/ws/WSDL', 'clsDisplayRectangle');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme.atbx.net/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsGetExistingOrderData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetExistingOrderData');
  RemClassRegistry.RegisterXSClass(clsGetOrderData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetOrderData');
  RemClassRegistry.RegisterXSClass(clsUpdateMemberInformationResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUpdateMemberInformationResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsGetClientVersionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClientVersionResponse');
  RemClassRegistry.RegisterXSClass(clsGetClientVersionData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClientVersionData');
  RemClassRegistry.RegisterXSClass(clsGetNewOrderResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetNewOrderResponse');
  RemClassRegistry.RegisterXSClass(clsGetOrder2Data, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetOrder2Data');
  RemClassRegistry.RegisterXSClass(clsGetNewOrder2Response, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetNewOrder2Response');
  RemClassRegistry.RegisterXSClass(clsGetOrder3Data, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetOrder3Data');
  RemClassRegistry.RegisterXSClass(clsGetNewOrder3Response, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetNewOrder3Response');
  RemClassRegistry.RegisterXSClass(clsGetExistingOrderResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetExistingOrderResponse');
  RemClassRegistry.RegisterXSClass(clsAddLenderReferenceResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddLenderReferenceResponse');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenResponse');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenData');
  RemClassRegistry.RegisterXSClass(clsGetSignatureDetailsData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSignatureDetailsData');
  RemClassRegistry.RegisterXSClass(clsGetSignatureDetailsResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSignatureDetailsResponse');
  RemClassRegistry.RegisterXSClass(clsGetSignatureLastChangeDateResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSignatureLastChangeDateResponse');
  RemClassRegistry.RegisterXSClass(clsInitializeConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsInitializeConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsCompanyList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsCompanyList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsProductList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsProductList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsOpenOrderList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsOpenOrderList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsPromotionList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsPromotionList');
  RemClassRegistry.RegisterXSClass(clsInitializeConnectionData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsInitializeConnectionData');
  RemClassRegistry.RegisterXSClass(clsProductListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsProductListItem');
  RemClassRegistry.RegisterXSClass(clsPromotionListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsPromotionListItem');
  RemClassRegistry.RegisterXSClass(clsIsMemberResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsMemberResponseData');
  RemClassRegistry.RegisterXSClass(clsIsMemberResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsMemberResponse');
  RemClassRegistry.RegisterXSClass(clsGetMemberInformationResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMemberInformationResponse');
  RemClassRegistry.RegisterXSClass(clsGetMemberInformationData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMemberInformationData');
  RemClassRegistry.RegisterXSClass(clsLicenseItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsLicenseItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsLicenseItemArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsLicenseItemArray');
  RemClassRegistry.RegisterXSClass(clsGetMemberInformation2Data, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMemberInformation2Data');
  RemClassRegistry.RegisterXSClass(clsGetMemberInformation2Response, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMemberInformation2Response');
  RemClassRegistry.RegisterXSClass(clsSendMessageResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSendMessageResponse');
  RemClassRegistry.RegisterXSClass(clsSendExternalEmailResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSendExternalEmailResponse');
  RemClassRegistry.RegisterXSClass(clsGetClickformsSecurityTokenResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClickformsSecurityTokenResponseData');
  RemClassRegistry.RegisterXSClass(clsGetClickformsSecurityTokenResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClickformsSecurityTokenResponse');
  RemClassRegistry.RegisterXSClass(clsAttachmentListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAttachmentListItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAttachmentList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAttachmentList');
  RemClassRegistry.RegisterXSClass(clsToListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsToListItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsToListItem), 'Name_', 'Name');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsToList), 'http://carme.atbx.net/secure/ws/WSDL', 'clsToList');
  RemClassRegistry.RegisterXSClass(clsAccessCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAccessCredentials');
  RemClassRegistry.RegisterXSClass(clsAwsiOrderDetailsRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAwsiOrderDetailsRequest');
  RemClassRegistry.RegisterXSClass(clsAddressDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddressDetails');
  RemClassRegistry.RegisterXSClass(clsNewOrderDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsNewOrderDetails');
  RemClassRegistry.RegisterXSClass(clsMemberInformationCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMemberInformationCredentials');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsGetClientVersionRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClientVersionRequest');
  RemClassRegistry.RegisterXSClass(clsAwsiNewOrderDetailsRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAwsiNewOrderDetailsRequest');
  RemClassRegistry.RegisterXSClass(clsAwsiNewOrder2DetailsRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAwsiNewOrder2DetailsRequest');
  RemClassRegistry.RegisterXSClass(clsAwsiNewOrder3DetailsRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAwsiNewOrder3DetailsRequest');
  RemClassRegistry.RegisterXSClass(clsLenderReferenceDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsLenderReferenceDetails');
  RemClassRegistry.RegisterXSClass(clsAwsiAccessDetailsRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAwsiAccessDetailsRequest');
  RemClassRegistry.RegisterXSClass(clsIsMemberCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsMemberCredentials');
  RemClassRegistry.RegisterXSClass(clsGetMemberInformationCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMemberInformationCredentials');
  RemClassRegistry.RegisterXSClass(clsSendMessageCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSendMessageCredentials');
  RemClassRegistry.RegisterXSClass(clsSendMessageRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSendMessageRequest');
  RemClassRegistry.RegisterXSClass(clsSendExternalEmailRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSendExternalEmailRequest');
  RemClassRegistry.RegisterXSClass(clsUpdateMemberInformationData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUpdateMemberInformationData');
  RemClassRegistry.RegisterXSClass(clsUpdateMemberInformationCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUpdateMemberInformationCredentials');
  RemClassRegistry.RegisterXSClass(clsSignatureUpdateDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSignatureUpdateDetails');
  RemClassRegistry.RegisterXSClass(clsUpdateMemberInformation2Data, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUpdateMemberInformation2Data');
  RemClassRegistry.RegisterXSClass(clsGetClickformsSecurityTokenCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetClickformsSecurityTokenCredentials');
  RemClassRegistry.RegisterXSInfo(TypeInfo(key), 'http://carme.atbx.net/secure/ws/WSDL', 'key');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://carme.atbx.net/secure/ws/WSDL', 'ArrayOfString');
  RemClassRegistry.RegisterXSClass(clsOpenOrderListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsOpenOrderListItem');
  RemClassRegistry.RegisterXSClass(clsCompanyListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCompanyListItem');

end.