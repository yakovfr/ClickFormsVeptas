
{*****************************************************************************************}
{                                                                                         }
{               XML Data Binding                                                          }
{                                                                                         }
{         Generated on: 10/20/2010                                                        }
{           Updated on:  5/11/2011                                                        }
{       Generated from: B:\Development\ClickFORMS AMC Suite\ODP\ODP\AMC_ODP.xsd           }
{   Settings stored in: B:\Development\ClickFORMS AMC Suite\ODP\ODP\AMC_ODP.xdb           }
{                                                                                         }
{*****************************************************************************************}

unit UAMC_ODP;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLREQUEST_GROUP = interface;
  IXMLSUBMITTING_PARTYType = interface;
  IXMLREQUESTType = interface;
  IXMLREQUEST_DATAType = interface;
  IXMLVALUATION_REQUESTType = interface;
  IXMLSERVICE_PAYMENT = interface;
  IXMLLOANType = interface;
  IXML_APPLICATIONType = interface;
  IXMLLOAN_PURPOSEType = interface;
  IXMLMORTGAGE_TERMSType = interface;
  IXMLPROPERTYType = interface;
  IXMLPARSED_STREET_ADDRESSType = interface;
  IXML_IDENTIFICATION = interface;
  IXML_LEGAL_DESCRIPTIONType = interface;
  IXMLSTRUCTUREType = interface;
  IXML_TAX = interface;
  IXMLSALES_HISTORYType = interface;
  IXML_PRODUCTType = interface;
  IXML_NAMEType = interface;
  IXML_ADDONType = interface;
  IXMLPARTIESType = interface;
  IXMLAPPRAISERType = interface;
  IXMLLENDERType = interface;
  IXMLBORROWERType = interface;
  IXMLBORROWERTypeList = interface;
  IXMLCONTACT_DETAILType = interface;
  IXMLCONTACT_POINTType = interface;
  IXMLCOMPLIANCE_GUIDELINEType = interface;
  IXMLGUIDELINEType = interface;
  IXMLSPECIAL_INSTRUCTIONSType = interface;
  IXMLINSTRUCTIONType = interface;

{ IXMLREQUEST_GROUP }

  IXMLREQUEST_GROUP = interface(IXMLNode)
    ['{7BE266A6-CD5D-4BDD-8894-BF1C8849267D}']
    { Property Accessors }
    function Get_MISMOVersionID: WideString;
    function Get_SUBMITTING_PARTY: IXMLSUBMITTING_PARTYType;
    function Get_REQUEST: IXMLREQUESTType;
    procedure Set_MISMOVersionID(Value: WideString);
    { Methods & Properties }
    property MISMOVersionID: WideString read Get_MISMOVersionID write Set_MISMOVersionID;
    property SUBMITTING_PARTY: IXMLSUBMITTING_PARTYType read Get_SUBMITTING_PARTY;
    property REQUEST: IXMLREQUESTType read Get_REQUEST;
  end;

{ IXMLSUBMITTING_PARTYType }

  IXMLSUBMITTING_PARTYType = interface(IXMLNode)
    ['{971AE4E4-2147-4AFE-B8C8-EF6FBC3E1CAB}']
    { Property Accessors }
    function Get__Name: WideString;
    function Get__TransactionIdentifier: WideString;
    procedure Set__Name(Value: WideString);
    procedure Set__TransactionIdentifier(Value: WideString);
    { Methods & Properties }
    property _Name: WideString read Get__Name write Set__Name;
    property _TransactionIdentifier: WideString read Get__TransactionIdentifier write Set__TransactionIdentifier;
  end;

{ IXMLREQUESTType }

  IXMLREQUESTType = interface(IXMLNode)
    ['{5B883137-D31B-41FA-8430-433722448C01}']
    { Property Accessors }
    function Get_REQUEST_DATA: IXMLREQUEST_DATAType;
    { Methods & Properties }
    property REQUEST_DATA: IXMLREQUEST_DATAType read Get_REQUEST_DATA;
  end;

{ IXMLREQUEST_DATAType }

  IXMLREQUEST_DATAType = interface(IXMLNode)
    ['{911757A9-4377-43E6-BBB5-8D21A0B79558}']
    { Property Accessors }
    function Get_VALUATION_REQUEST: IXMLVALUATION_REQUESTType;
    { Methods & Properties }
    property VALUATION_REQUEST: IXMLVALUATION_REQUESTType read Get_VALUATION_REQUEST;
  end;

{ IXMLVALUATION_REQUESTType }

  IXMLVALUATION_REQUESTType = interface(IXMLNode)
    ['{85361B1F-7B2D-4814-9981-A8133A5392DC}']
    { Property Accessors }
    function Get__RushIndicator: WideString;
    function Get__CommentText: WideString;
    function Get_SERVICE_PAYMENT: IXMLSERVICE_PAYMENT;
    function Get_LOAN: IXMLLOANType;
    function Get__PRODUCT: IXML_PRODUCTType;
    function Get_PARTIES: IXMLPARTIESType;
    function Get_COMPLIANCE_GUIDELINE: IXMLCOMPLIANCE_GUIDELINEType;
    function Get_SPECIAL_INSTRUCTIONS: IXMLSPECIAL_INSTRUCTIONSType;
    procedure Set__RushIndicator(Value: WideString);
    procedure Set__CommentText(Value: WideString);
    { Methods & Properties }
    property _RushIndicator: WideString read Get__RushIndicator write Set__RushIndicator;
    property _CommentText: WideString read Get__CommentText write Set__CommentText;
    property SERVICE_PAYMENT: IXMLSERVICE_PAYMENT read Get_SERVICE_PAYMENT;
    property LOAN: IXMLLOANType read Get_LOAN;
    property _PRODUCT: IXML_PRODUCTType read Get__PRODUCT;
    property PARTIES: IXMLPARTIESType read Get_PARTIES;
    property COMPLIANCE_GUIDELINE: IXMLCOMPLIANCE_GUIDELINEType read Get_COMPLIANCE_GUIDELINE;
    property SPECIAL_INSTRUCTIONS: IXMLSPECIAL_INSTRUCTIONSType read Get_SPECIAL_INSTRUCTIONS;
  end;

{ IXMLSERVICE_PAYMENT }

  IXMLSERVICE_PAYMENT = interface(IXMLNode)
    ['{115BD8CC-6ACE-43C5-987A-DAABF13D5D45}']
  end;

{ IXMLLOANType }

  IXMLLOANType = interface(IXMLNode)
    ['{E0AE9F4D-1814-42F2-A763-D05AB5664362}']
    { Property Accessors }
    function Get__APPLICATION: IXML_APPLICATIONType;
    { Methods & Properties }
    property _APPLICATION: IXML_APPLICATIONType read Get__APPLICATION;
  end;

{ IXML_APPLICATIONType }

  IXML_APPLICATIONType = interface(IXMLNode)
    ['{61AD82BC-82DD-46A4-BA83-7918577DD08D}']
    { Property Accessors }
    function Get_LOAN_PURPOSE: IXMLLOAN_PURPOSEType;
    function Get_MORTGAGE_TERMS: IXMLMORTGAGE_TERMSType;
    function Get_PROPERTY_: IXMLPROPERTYType;
    { Methods & Properties }
    property LOAN_PURPOSE: IXMLLOAN_PURPOSEType read Get_LOAN_PURPOSE;
    property MORTGAGE_TERMS: IXMLMORTGAGE_TERMSType read Get_MORTGAGE_TERMS;
    property PROPERTY_: IXMLPROPERTYType read Get_PROPERTY_;
  end;

{ IXMLLOAN_PURPOSEType }

  IXMLLOAN_PURPOSEType = interface(IXMLNode)
    ['{00C544FC-8469-4300-8D1D-5E41D7C476A6}']
    { Property Accessors }
    function Get__Type: WideString;
    procedure Set__Type(Value: WideString);
    { Methods & Properties }
    property _Type: WideString read Get__Type write Set__Type;
  end;

{ IXMLMORTGAGE_TERMSType }

  IXMLMORTGAGE_TERMSType = interface(IXMLNode)
    ['{5F3541AD-FC12-4C15-BF82-A42477F35B94}']
    { Property Accessors }
    function Get_LenderCaseIdentifier: WideString;
    function Get_FHACaseIdentifier: WideString;
    function Get_MortgageType: WideString;
    function Get_LoanAmount: WideString;
    procedure Set_LenderCaseIdentifier(Value: WideString);
    procedure Set_FHACaseIdentifier(Value: WideString);
    procedure Set_MortgageType(Value: WideString);
    procedure Set_LoanAmount(Value: WideString);
    { Methods & Properties }
    property LenderCaseIdentifier: WideString read Get_LenderCaseIdentifier write Set_LenderCaseIdentifier;
    property FHACaseIdentifier: WideString read Get_FHACaseIdentifier write Set_FHACaseIdentifier;
    property MortgageType: WideString read Get_MortgageType write Set_MortgageType;
    property LoanAmount: WideString read Get_LoanAmount write Set_LoanAmount;
  end;

{ IXMLPROPERTYType }

  IXMLPROPERTYType = interface(IXMLNode)
    ['{ACEA4ECE-AFB2-40C6-A97B-F5D29ED11B86}']
    { Property Accessors }
    function Get_PropertyDescription: WideString;
    function Get__StreetAddress: WideString;
    function Get__UnitNo: WideString;
    function Get__City: WideString;
    function Get__State: WideString;
    function Get__County: WideString;
    function Get__PostalCode: WideString;
    function Get__CurrentOccupancyType: WideString;
    function Get__StreetAddress2: WideString;
    function Get__YearBuilt: WideString;
    function Get_PARSED_STREET_ADDRESS: IXMLPARSED_STREET_ADDRESSType;
    function Get__IDENTIFICATION: IXML_IDENTIFICATION;
    function Get__LEGAL_DESCRIPTION: IXML_LEGAL_DESCRIPTIONType;
    function Get_STRUCTURE: IXMLSTRUCTUREType;
    function Get__TAX: IXML_TAX;
    function Get_SALES_HISTORY: IXMLSALES_HISTORYType;
    procedure Set_PropertyDescription(Value: WideString);
    procedure Set__StreetAddress(Value: WideString);
    procedure Set__UnitNo(Value: WideString);
    procedure Set__City(Value: WideString);
    procedure Set__State(Value: WideString);
    procedure Set__County(Value: WideString);
    procedure Set__PostalCode(Value: WideString);
    procedure Set__CurrentOccupancyType(Value: WideString);
    procedure Set__StreetAddress2(Value: WideString);
    procedure Set__YearBuilt(Value: WideString);
    { Methods & Properties }
    property PropertyDescription: WideString read Get_PropertyDescription write Set_PropertyDescription;
    property _StreetAddress: WideString read Get__StreetAddress write Set__StreetAddress;
    property _UnitNo: WideString read Get__UnitNo write Set__UnitNo;
    property _City: WideString read Get__City write Set__City;
    property _State: WideString read Get__State write Set__State;
    property _County: WideString read Get__County write Set__County;
    property _PostalCode: WideString read Get__PostalCode write Set__PostalCode;
    property _CurrentOccupancyType: WideString read Get__CurrentOccupancyType write Set__CurrentOccupancyType;
    property _StreetAddress2: WideString read Get__StreetAddress2 write Set__StreetAddress2;
    property _YearBuilt: WideString read Get__YearBuilt write Set__YearBuilt;
    property PARSED_STREET_ADDRESS: IXMLPARSED_STREET_ADDRESSType read Get_PARSED_STREET_ADDRESS;
    property _IDENTIFICATION: IXML_IDENTIFICATION read Get__IDENTIFICATION;
    property _LEGAL_DESCRIPTION: IXML_LEGAL_DESCRIPTIONType read Get__LEGAL_DESCRIPTION;
    property STRUCTURE: IXMLSTRUCTUREType read Get_STRUCTURE;
    property _TAX: IXML_TAX read Get__TAX;
    property SALES_HISTORY: IXMLSALES_HISTORYType read Get_SALES_HISTORY;
  end;

{ IXMLPARSED_STREET_ADDRESSType }

  IXMLPARSED_STREET_ADDRESSType = interface(IXMLNode)
    ['{B960A869-033A-45B6-8128-C29B39D855F5}']
    { Property Accessors }
    function Get__StreetName: WideString;
    procedure Set__StreetName(Value: WideString);
    { Methods & Properties }
    property _StreetName: WideString read Get__StreetName write Set__StreetName;
  end;

{ IXML_IDENTIFICATION }

  IXML_IDENTIFICATION = interface(IXMLNode)
    ['{D955FBE6-D90A-4354-ABE4-15AAD15020D9}']
  end;

{ IXML_LEGAL_DESCRIPTIONType }

  IXML_LEGAL_DESCRIPTIONType = interface(IXMLNode)
    ['{8175128E-E1CA-4DCA-B8CD-89B7EEB72E49}']
    { Property Accessors }
    function Get__TextDescription: WideString;
    procedure Set__TextDescription(Value: WideString);
    { Methods & Properties }
    property _TextDescription: WideString read Get__TextDescription write Set__TextDescription;
  end;

{ IXMLSTRUCTUREType }

  IXMLSTRUCTUREType = interface(IXMLNode)
    ['{9EEDCF2A-0744-4C68-B517-5BE62286EA7B}']
    { Property Accessors }
    function Get_BuildingStatusType: WideString;
    procedure Set_BuildingStatusType(Value: WideString);
    function Get_PropertyCategoryType: WideString;
    procedure Set_PropertyCategoryType(Value: WideString);
    { Methods & Properties }
    property BuildingStatusType: WideString read Get_BuildingStatusType write Set_BuildingStatusType;
    property PropertyCategoryType: WideString read Get_PropertyCategoryType write Set_PropertyCategoryType;
  end;

{ IXML_TAX }

  IXML_TAX = interface(IXMLNode)
    ['{4BFAF181-7869-45E4-B141-66BE26889A66}']
  end;

{ IXMLSALES_HISTORYType }

  IXMLSALES_HISTORYType = interface(IXMLNode)
    ['{2BD8738C-7EFF-45B0-8989-4EA4DEF2C515}']
    { Property Accessors }
    function Get_PropertyEstValue: WideString;
    function Get_PropertySalesAmount: WideString;
    procedure Set_PropertyEstValue(Value: WideString);
    procedure Set_PropertySalesAmount(Value: WideString);
    { Methods & Properties }
    property PropertyEstValue: WideString read Get_PropertyEstValue write Set_PropertyEstValue;
    property PropertySalesAmount: WideString read Get_PropertySalesAmount write Set_PropertySalesAmount;
  end;

{ IXML_PRODUCTType }

  IXML_PRODUCTType = interface(IXMLNode)
    ['{12EB2A50-DDE1-46DA-899F-5AAD3DBAFFA1}']
    { Property Accessors }
    function Get_ServiceRequestedCompletionDueDate: WideString;
    function Get_ServiceRequestedPriceAmount: WideString;
    function Get__NAME: IXML_NAMEType;
    procedure Set_ServiceRequestedCompletionDueDate(Value: WideString);
    procedure Set_ServiceRequestedPriceAmount(Value: WideString);
    { Methods & Properties }
    property ServiceRequestedCompletionDueDate: WideString read Get_ServiceRequestedCompletionDueDate write Set_ServiceRequestedCompletionDueDate;
    property ServiceRequestedPriceAmount: WideString read Get_ServiceRequestedPriceAmount write Set_ServiceRequestedPriceAmount;
    property _NAME: IXML_NAMEType read Get__NAME;
  end;

{ IXML_NAMEType }

  IXML_NAMEType = interface(IXMLNodeCollection)
    ['{8553F696-DBBE-48ED-8E2D-92228A7A8900}']
    { Property Accessors }
    function Get__Description: WideString;
    function Get__ADDON(Index: Integer): IXML_ADDONType;
    procedure Set__Description(Value: WideString);
    { Methods & Properties }
    function Add: IXML_ADDONType;
    function Insert(const Index: Integer): IXML_ADDONType;
    property _Description: WideString read Get__Description write Set__Description;
    property _ADDON[Index: Integer]: IXML_ADDONType read Get__ADDON; default;
  end;

{ IXML_ADDONType }

  IXML_ADDONType = interface(IXMLNode)
    ['{1F0E776F-A4F8-4DD6-96A1-42702F1FA6A6}']
    { Property Accessors }
    function Get__Type: WideString;
    function Get__AddOnServiceDescription: WideString;
    function Get__AddOnServicePriceAmount: WideString;
    procedure Set__Type(Value: WideString);
    procedure Set__AddOnServiceDescription(Value: WideString);
    procedure Set__AddOnServicePriceAmount(Value: WideString);
    { Methods & Properties }
    property _Type: WideString read Get__Type write Set__Type;
    property _AddOnServiceDescription: WideString read Get__AddOnServiceDescription write Set__AddOnServiceDescription;
    property _AddOnServicePriceAmount: WideString read Get__AddOnServicePriceAmount write Set__AddOnServicePriceAmount;
  end;

{ IXMLPARTIESType }

  IXMLPARTIESType = interface(IXMLNode)
    ['{4A46B18A-436C-4E04-A6A7-2A43B73E8BBD}']
    { Property Accessors }
    function Get_APPRAISER: IXMLAPPRAISERType;
    function Get_LENDER: IXMLLENDERType;
    function Get_BORROWER: IXMLBORROWERTypeList;
    { Methods & Properties }
    property APPRAISER: IXMLAPPRAISERType read Get_APPRAISER;
    property LENDER: IXMLLENDERType read Get_LENDER;
    property BORROWER: IXMLBORROWERTypeList read Get_BORROWER;
  end;

{ IXMLAPPRAISERType }

  IXMLAPPRAISERType = interface(IXMLNode)
    ['{FF05E631-28B4-4285-BF69-98FA70292D48}']
    { Property Accessors }
    function Get__Identifier: WideString;
    function Get__Name: WideString;
    function Get__Phone: WideString;
    function Get__Fax: WideString;
    procedure Set__Identifier(Value: WideString);
    procedure Set__Name(Value: WideString);
    procedure Set__Phone(Value: WideString);
    procedure Set__Fax(Value: WideString);
    { Methods & Properties }
    property _Identifier: WideString read Get__Identifier write Set__Identifier;
    property _Name: WideString read Get__Name write Set__Name;
    property _Phone: WideString read Get__Phone write Set__Phone;
    property _Fax: WideString read Get__Fax write Set__Fax;
  end;

{ IXMLLENDERType }

  IXMLLENDERType = interface(IXMLNode)
    ['{052C9DA4-ACD2-4BF0-B99F-99E220432834}']
    { Property Accessors }
    function Get__City: WideString;
    function Get__UnparsedName: WideString;
    function Get__StreetAddress: WideString;
    function Get__State: WideString;
    function Get__PostalCode: WideString;
    function Get__Phone: WideString;
    function Get__Fax: WideString;
    function Get__Email: WideString;
    procedure Set__City(Value: WideString);
    procedure Set__UnparsedName(Value: WideString);
    procedure Set__StreetAddress(Value: WideString);
    procedure Set__State(Value: WideString);
    procedure Set__PostalCode(Value: WideString);
    procedure Set__Phone(Value: WideString);
    procedure Set__Fax(Value: WideString);
    procedure Set__Email(Value: WideString);
    { Methods & Properties }
    property _City: WideString read Get__City write Set__City;
    property _UnparsedName: WideString read Get__UnparsedName write Set__UnparsedName;
    property _StreetAddress: WideString read Get__StreetAddress write Set__StreetAddress;
    property _State: WideString read Get__State write Set__State;
    property _PostalCode: WideString read Get__PostalCode write Set__PostalCode;
    property _Phone: WideString read Get__Phone write Set__Phone;
    property _Fax: WideString read Get__Fax write Set__Fax;
    property _Email: WideString read Get__Email write Set__Email;
  end;

{ IXMLBORROWERType }

  IXMLBORROWERType = interface(IXMLNode)
    ['{35A5B374-7D04-4F32-BDEB-1543B5C46929}']
    { Property Accessors }
    function Get__PrintPositionType: WideString;
    function Get__LastName: WideString;
    function Get__FirstName: WideString;
    function Get_CONTACT_DETAIL: IXMLCONTACT_DETAILType;
    procedure Set__PrintPositionType(Value: WideString);
    procedure Set__LastName(Value: WideString);
    procedure Set__FirstName(Value: WideString);
    { Methods & Properties }
    property _PrintPositionType: WideString read Get__PrintPositionType write Set__PrintPositionType;
    property _LastName: WideString read Get__LastName write Set__LastName;
    property _FirstName: WideString read Get__FirstName write Set__FirstName;
    property CONTACT_DETAIL: IXMLCONTACT_DETAILType read Get_CONTACT_DETAIL;
  end;

{ IXMLBORROWERTypeList }

  IXMLBORROWERTypeList = interface(IXMLNodeCollection)
    ['{6F7A192C-441F-4389-BC8C-C5C704C6EC9D}']
    { Methods & Properties }
    function Add: IXMLBORROWERType;
    function Insert(const Index: Integer): IXMLBORROWERType;
    function Get_Item(Index: Integer): IXMLBORROWERType;
    property Items[Index: Integer]: IXMLBORROWERType read Get_Item; default;
  end;

{ IXMLCONTACT_DETAILType }

  IXMLCONTACT_DETAILType = interface(IXMLNodeCollection)
    ['{EB8F09A2-4F6D-4017-8993-4E5696BE28B3}']
    { Property Accessors }
    function Get_CONTACT_POINT(Index: Integer): IXMLCONTACT_POINTType;
    { Methods & Properties }
    function Add: IXMLCONTACT_POINTType;
    function Insert(const Index: Integer): IXMLCONTACT_POINTType;
    property CONTACT_POINT[Index: Integer]: IXMLCONTACT_POINTType read Get_CONTACT_POINT; default;
  end;

{ IXMLCONTACT_POINTType }

  IXMLCONTACT_POINTType = interface(IXMLNode)
    ['{0CD5B762-EE55-4C8F-8129-9267B3397008}']
    { Property Accessors }
    function Get__Type: WideString;
    function Get__RoleType: WideString;
    function Get__Value: WideString;
    procedure Set__Type(Value: WideString);
    procedure Set__RoleType(Value: WideString);
    procedure Set__Value(Value: WideString);
    { Methods & Properties }
    property _Type: WideString read Get__Type write Set__Type;
    property _RoleType: WideString read Get__RoleType write Set__RoleType;
    property _Value: WideString read Get__Value write Set__Value;
  end;

{ IXMLCOMPLIANCE_GUIDELINEType }

  IXMLCOMPLIANCE_GUIDELINEType = interface(IXMLNodeCollection)
    ['{D60DC466-E216-4709-AB7D-455F09E7E42B}']
    { Property Accessors }
    function Get_GUIDELINE(Index: Integer): IXMLGUIDELINEType;
    { Methods & Properties }
    function Add: IXMLGUIDELINEType;
    function Insert(const Index: Integer): IXMLGUIDELINEType;
    property GUIDELINE[Index: Integer]: IXMLGUIDELINEType read Get_GUIDELINE; default;
  end;

{ IXMLGUIDELINEType }

  IXMLGUIDELINEType = interface(IXMLNode)
    ['{0FA5E176-BA3C-4D78-8872-3825C5D1C99D}']
    { Property Accessors }
    function Get__SequenceIdentifier: WideString;
    function Get__Description: WideString;
    procedure Set__SequenceIdentifier(Value: WideString);
    procedure Set__Description(Value: WideString);
    { Methods & Properties }
    property _SequenceIdentifier: WideString read Get__SequenceIdentifier write Set__SequenceIdentifier;
    property _Description: WideString read Get__Description write Set__Description;
  end;

{ IXMLSPECIAL_INSTRUCTIONSType }

  IXMLSPECIAL_INSTRUCTIONSType = interface(IXMLNodeCollection)
    ['{4EF14E3D-46D4-4FF0-B4E7-3A5F8CA2065F}']
    { Property Accessors }
    function Get_INSTRUCTION(Index: Integer): IXMLINSTRUCTIONType;
    { Methods & Properties }
    function Add: IXMLINSTRUCTIONType;
    function Insert(const Index: Integer): IXMLINSTRUCTIONType;
    property INSTRUCTION[Index: Integer]: IXMLINSTRUCTIONType read Get_INSTRUCTION; default;
  end;

{ IXMLINSTRUCTIONType }

  IXMLINSTRUCTIONType = interface(IXMLNode)
    ['{3E8960B9-468C-4975-9302-FD4D7BB06A66}']
    { Property Accessors }
    function Get__SequenceIdentifier: WideString;
    function Get__Description: WideString;
    procedure Set__SequenceIdentifier(Value: WideString);
    procedure Set__Description(Value: WideString);
    { Methods & Properties }
    property _SequenceIdentifier: WideString read Get__SequenceIdentifier write Set__SequenceIdentifier;
    property _Description: WideString read Get__Description write Set__Description;
  end;

{ Forward Decls }

  TXMLREQUEST_GROUP = class;
  TXMLSUBMITTING_PARTYType = class;
  TXMLREQUESTType = class;
  TXMLREQUEST_DATAType = class;
  TXMLVALUATION_REQUESTType = class;
  TXMLSERVICE_PAYMENT = class;
  TXMLLOANType = class;
  TXML_APPLICATIONType = class;
  TXMLLOAN_PURPOSEType = class;
  TXMLMORTGAGE_TERMSType = class;
  TXMLPROPERTYType = class;
  TXMLPARSED_STREET_ADDRESSType = class;
  TXML_IDENTIFICATION = class;
  TXML_LEGAL_DESCRIPTIONType = class;
  TXMLSTRUCTUREType = class;
  TXML_TAX = class;
  TXMLSALES_HISTORYType = class;
  TXML_PRODUCTType = class;
  TXML_NAMEType = class;
  TXML_ADDONType = class;
  TXMLPARTIESType = class;
  TXMLAPPRAISERType = class;
  TXMLLENDERType = class;
  TXMLBORROWERType = class;
  TXMLBORROWERTypeList = class;
  TXMLCONTACT_DETAILType = class;
  TXMLCONTACT_POINTType = class;
  TXMLCOMPLIANCE_GUIDELINEType = class;
  TXMLGUIDELINEType = class;
  TXMLSPECIAL_INSTRUCTIONSType = class;
  TXMLINSTRUCTIONType = class;

{ TXMLREQUEST_GROUP }

  TXMLREQUEST_GROUP = class(TXMLNode, IXMLREQUEST_GROUP)
  protected
    { IXMLREQUEST_GROUP }
    function Get_MISMOVersionID: WideString;
    function Get_SUBMITTING_PARTY: IXMLSUBMITTING_PARTYType;
    function Get_REQUEST: IXMLREQUESTType;
    procedure Set_MISMOVersionID(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSUBMITTING_PARTYType }

  TXMLSUBMITTING_PARTYType = class(TXMLNode, IXMLSUBMITTING_PARTYType)
  protected
    { IXMLSUBMITTING_PARTYType }
    function Get__Name: WideString;
    function Get__TransactionIdentifier: WideString;
    procedure Set__Name(Value: WideString);
    procedure Set__TransactionIdentifier(Value: WideString);
  end;

{ TXMLREQUESTType }

  TXMLREQUESTType = class(TXMLNode, IXMLREQUESTType)
  protected
    { IXMLREQUESTType }
    function Get_REQUEST_DATA: IXMLREQUEST_DATAType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLREQUEST_DATAType }

  TXMLREQUEST_DATAType = class(TXMLNode, IXMLREQUEST_DATAType)
  protected
    { IXMLREQUEST_DATAType }
    function Get_VALUATION_REQUEST: IXMLVALUATION_REQUESTType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVALUATION_REQUESTType }

  TXMLVALUATION_REQUESTType = class(TXMLNode, IXMLVALUATION_REQUESTType)
  protected
    { IXMLVALUATION_REQUESTType }
    function Get__RushIndicator: WideString;
    function Get__CommentText: WideString;
    function Get_SERVICE_PAYMENT: IXMLSERVICE_PAYMENT;
    function Get_LOAN: IXMLLOANType;
    function Get__PRODUCT: IXML_PRODUCTType;
    function Get_PARTIES: IXMLPARTIESType;
    function Get_COMPLIANCE_GUIDELINE: IXMLCOMPLIANCE_GUIDELINEType;
    function Get_SPECIAL_INSTRUCTIONS: IXMLSPECIAL_INSTRUCTIONSType;
    procedure Set__RushIndicator(Value: WideString);
    procedure Set__CommentText(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSERVICE_PAYMENT }

  TXMLSERVICE_PAYMENT = class(TXMLNode, IXMLSERVICE_PAYMENT)
  protected
    { IXMLSERVICE_PAYMENT }
  end;

{ TXMLLOANType }

  TXMLLOANType = class(TXMLNode, IXMLLOANType)
  protected
    { IXMLLOANType }
    function Get__APPLICATION: IXML_APPLICATIONType;
  public
    procedure AfterConstruction; override;
  end;

{ TXML_APPLICATIONType }

  TXML_APPLICATIONType = class(TXMLNode, IXML_APPLICATIONType)
  protected
    { IXML_APPLICATIONType }
    function Get_LOAN_PURPOSE: IXMLLOAN_PURPOSEType;
    function Get_MORTGAGE_TERMS: IXMLMORTGAGE_TERMSType;
    function Get_PROPERTY_: IXMLPROPERTYType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLOAN_PURPOSEType }

  TXMLLOAN_PURPOSEType = class(TXMLNode, IXMLLOAN_PURPOSEType)
  protected
    { IXMLLOAN_PURPOSEType }
    function Get__Type: WideString;
    procedure Set__Type(Value: WideString);
  end;

{ TXMLMORTGAGE_TERMSType }

  TXMLMORTGAGE_TERMSType = class(TXMLNode, IXMLMORTGAGE_TERMSType)
  protected
    { IXMLMORTGAGE_TERMSType }
    function Get_LenderCaseIdentifier: WideString;
    function Get_FHACaseIdentifier: WideString;
    function Get_MortgageType: WideString;
    function Get_LoanAmount: WideString;
    procedure Set_LenderCaseIdentifier(Value: WideString);
    procedure Set_FHACaseIdentifier(Value: WideString);
    procedure Set_MortgageType(Value: WideString);
    procedure Set_LoanAmount(Value: WideString);
  end;

{ TXMLPROPERTYType }

  TXMLPROPERTYType = class(TXMLNode, IXMLPROPERTYType)
  protected
    { IXMLPROPERTYType }
    function Get_PropertyDescription: WideString;
    function Get__StreetAddress: WideString;
    function Get__UnitNo: WideString;
    function Get__City: WideString;
    function Get__State: WideString;
    function Get__County: WideString;
    function Get__PostalCode: WideString;
    function Get__CurrentOccupancyType: WideString;
    function Get__StreetAddress2: WideString;
    function Get__YearBuilt: WideString;
    function Get_PARSED_STREET_ADDRESS: IXMLPARSED_STREET_ADDRESSType;
    function Get__IDENTIFICATION: IXML_IDENTIFICATION;
    function Get__LEGAL_DESCRIPTION: IXML_LEGAL_DESCRIPTIONType;
    function Get_STRUCTURE: IXMLSTRUCTUREType;
    function Get__TAX: IXML_TAX;
    function Get_SALES_HISTORY: IXMLSALES_HISTORYType;
    procedure Set_PropertyDescription(Value: WideString);
    procedure Set__StreetAddress(Value: WideString);
    procedure Set__UnitNo(Value: WideString);
    procedure Set__City(Value: WideString);
    procedure Set__State(Value: WideString);
    procedure Set__County(Value: WideString);
    procedure Set__PostalCode(Value: WideString);
    procedure Set__CurrentOccupancyType(Value: WideString);
    procedure Set__StreetAddress2(Value: WideString);
    procedure Set__YearBuilt(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPARSED_STREET_ADDRESSType }

  TXMLPARSED_STREET_ADDRESSType = class(TXMLNode, IXMLPARSED_STREET_ADDRESSType)
  protected
    { IXMLPARSED_STREET_ADDRESSType }
    function Get__StreetName: WideString;
    procedure Set__StreetName(Value: WideString);
  end;

{ TXML_IDENTIFICATION }

  TXML_IDENTIFICATION = class(TXMLNode, IXML_IDENTIFICATION)
  protected
    { IXML_IDENTIFICATION }
  end;

{ TXML_LEGAL_DESCRIPTIONType }

  TXML_LEGAL_DESCRIPTIONType = class(TXMLNode, IXML_LEGAL_DESCRIPTIONType)
  protected
    { IXML_LEGAL_DESCRIPTIONType }
    function Get__TextDescription: WideString;
    procedure Set__TextDescription(Value: WideString);
  end;

{ TXMLSTRUCTUREType }

  TXMLSTRUCTUREType = class(TXMLNode, IXMLSTRUCTUREType)
  protected
    { IXMLSTRUCTUREType }
    function Get_BuildingStatusType: WideString;
    procedure Set_BuildingStatusType(Value: WideString);
    function Get_PropertyCategoryType: WideString;
    procedure Set_PropertyCategoryType(Value: WideString);
  end;

{ TXML_TAX }

  TXML_TAX = class(TXMLNode, IXML_TAX)
  protected
    { IXML_TAX }
  end;

{ TXMLSALES_HISTORYType }

  TXMLSALES_HISTORYType = class(TXMLNode, IXMLSALES_HISTORYType)
  protected
    { IXMLSALES_HISTORYType }
    function Get_PropertyEstValue: WideString;
    function Get_PropertySalesAmount: WideString;
    procedure Set_PropertyEstValue(Value: WideString);
    procedure Set_PropertySalesAmount(Value: WideString);
  end;

{ TXML_PRODUCTType }

  TXML_PRODUCTType = class(TXMLNode, IXML_PRODUCTType)
  protected
    { IXML_PRODUCTType }
    function Get_ServiceRequestedCompletionDueDate: WideString;
    function Get_ServiceRequestedPriceAmount: WideString;
    function Get__NAME: IXML_NAMEType;
    procedure Set_ServiceRequestedCompletionDueDate(Value: WideString);
    procedure Set_ServiceRequestedPriceAmount(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXML_NAMEType }

  TXML_NAMEType = class(TXMLNodeCollection, IXML_NAMEType)
  protected
    { IXML_NAMEType }
    function Get__Description: WideString;
    function Get__ADDON(Index: Integer): IXML_ADDONType;
    procedure Set__Description(Value: WideString);
    function Add: IXML_ADDONType;
    function Insert(const Index: Integer): IXML_ADDONType;
  public
    procedure AfterConstruction; override;
  end;

{ TXML_ADDONType }

  TXML_ADDONType = class(TXMLNode, IXML_ADDONType)
  protected
    { IXML_ADDONType }
    function Get__Type: WideString;
    function Get__AddOnServiceDescription: WideString;
    function Get__AddOnServicePriceAmount: WideString;
    procedure Set__Type(Value: WideString);
    procedure Set__AddOnServiceDescription(Value: WideString);
    procedure Set__AddOnServicePriceAmount(Value: WideString);
  end;

{ TXMLPARTIESType }

  TXMLPARTIESType = class(TXMLNode, IXMLPARTIESType)
  private
    FBORROWER: IXMLBORROWERTypeList;
  protected
    { IXMLPARTIESType }
    function Get_APPRAISER: IXMLAPPRAISERType;
    function Get_LENDER: IXMLLENDERType;
    function Get_BORROWER: IXMLBORROWERTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAPPRAISERType }

  TXMLAPPRAISERType = class(TXMLNode, IXMLAPPRAISERType)
  protected
    { IXMLAPPRAISERType }
    function Get__Identifier: WideString;
    function Get__Name: WideString;
    function Get__Phone: WideString;
    function Get__Fax: WideString;
    procedure Set__Identifier(Value: WideString);
    procedure Set__Name(Value: WideString);
    procedure Set__Phone(Value: WideString);
    procedure Set__Fax(Value: WideString);
  end;

{ TXMLLENDERType }

  TXMLLENDERType = class(TXMLNode, IXMLLENDERType)
  protected
    { IXMLLENDERType }
    function Get__City: WideString;
    function Get__UnparsedName: WideString;
    function Get__StreetAddress: WideString;
    function Get__State: WideString;
    function Get__PostalCode: WideString;
    function Get__Phone: WideString;
    function Get__Fax: WideString;
    function Get__Email: WideString;
    procedure Set__City(Value: WideString);
    procedure Set__UnparsedName(Value: WideString);
    procedure Set__StreetAddress(Value: WideString);
    procedure Set__State(Value: WideString);
    procedure Set__PostalCode(Value: WideString);
    procedure Set__Phone(Value: WideString);
    procedure Set__Fax(Value: WideString);
    procedure Set__Email(Value: WideString);
  end;

{ TXMLBORROWERType }

  TXMLBORROWERType = class(TXMLNode, IXMLBORROWERType)
  protected
    { IXMLBORROWERType }
    function Get__PrintPositionType: WideString;
    function Get__LastName: WideString;
    function Get__FirstName: WideString;
    function Get_CONTACT_DETAIL: IXMLCONTACT_DETAILType;
    procedure Set__PrintPositionType(Value: WideString);
    procedure Set__LastName(Value: WideString);
    procedure Set__FirstName(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBORROWERTypeList }

  TXMLBORROWERTypeList = class(TXMLNodeCollection, IXMLBORROWERTypeList)
  protected
    { IXMLBORROWERTypeList }
    function Add: IXMLBORROWERType;
    function Insert(const Index: Integer): IXMLBORROWERType;
    function Get_Item(Index: Integer): IXMLBORROWERType;
  end;

{ TXMLCONTACT_DETAILType }

  TXMLCONTACT_DETAILType = class(TXMLNodeCollection, IXMLCONTACT_DETAILType)
  protected
    { IXMLCONTACT_DETAILType }
    function Get_CONTACT_POINT(Index: Integer): IXMLCONTACT_POINTType;
    function Add: IXMLCONTACT_POINTType;
    function Insert(const Index: Integer): IXMLCONTACT_POINTType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCONTACT_POINTType }

  TXMLCONTACT_POINTType = class(TXMLNode, IXMLCONTACT_POINTType)
  protected
    { IXMLCONTACT_POINTType }
    function Get__Type: WideString;
    function Get__RoleType: WideString;
    function Get__Value: WideString;
    procedure Set__Type(Value: WideString);
    procedure Set__RoleType(Value: WideString);
    procedure Set__Value(Value: WideString);
  end;

{ TXMLCOMPLIANCE_GUIDELINEType }

  TXMLCOMPLIANCE_GUIDELINEType = class(TXMLNodeCollection, IXMLCOMPLIANCE_GUIDELINEType)
  protected
    { IXMLCOMPLIANCE_GUIDELINEType }
    function Get_GUIDELINE(Index: Integer): IXMLGUIDELINEType;
    function Add: IXMLGUIDELINEType;
    function Insert(const Index: Integer): IXMLGUIDELINEType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGUIDELINEType }

  TXMLGUIDELINEType = class(TXMLNode, IXMLGUIDELINEType)
  protected
    { IXMLGUIDELINEType }
    function Get__SequenceIdentifier: WideString;
    function Get__Description: WideString;
    procedure Set__SequenceIdentifier(Value: WideString);
    procedure Set__Description(Value: WideString);
  end;

{ TXMLSPECIAL_INSTRUCTIONSType }

  TXMLSPECIAL_INSTRUCTIONSType = class(TXMLNodeCollection, IXMLSPECIAL_INSTRUCTIONSType)
  protected
    { IXMLSPECIAL_INSTRUCTIONSType }
    function Get_INSTRUCTION(Index: Integer): IXMLINSTRUCTIONType;
    function Add: IXMLINSTRUCTIONType;
    function Insert(const Index: Integer): IXMLINSTRUCTIONType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLINSTRUCTIONType }

  TXMLINSTRUCTIONType = class(TXMLNode, IXMLINSTRUCTIONType)
  protected
    { IXMLINSTRUCTIONType }
    function Get__SequenceIdentifier: WideString;
    function Get__Description: WideString;
    procedure Set__SequenceIdentifier(Value: WideString);
    procedure Set__Description(Value: WideString);
  end;

{ Global Functions }

function GetREQUEST_GROUP(Doc: IXMLDocument): IXMLREQUEST_GROUP;
function LoadREQUEST_GROUP(const FileName: WideString): IXMLREQUEST_GROUP;
function NewREQUEST_GROUP: IXMLREQUEST_GROUP;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetREQUEST_GROUP(Doc: IXMLDocument): IXMLREQUEST_GROUP;
begin
  Result := Doc.GetDocBinding('REQUEST_GROUP', TXMLREQUEST_GROUP, TargetNamespace) as IXMLREQUEST_GROUP;
end;

function LoadREQUEST_GROUP(const FileName: WideString): IXMLREQUEST_GROUP;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('REQUEST_GROUP', TXMLREQUEST_GROUP, TargetNamespace) as IXMLREQUEST_GROUP;
end;

function NewREQUEST_GROUP: IXMLREQUEST_GROUP;
begin
  Result := NewXMLDocument.GetDocBinding('REQUEST_GROUP', TXMLREQUEST_GROUP, TargetNamespace) as IXMLREQUEST_GROUP;
end;

{ TXMLREQUEST_GROUP }

procedure TXMLREQUEST_GROUP.AfterConstruction;
begin
  RegisterChildNode('SUBMITTING_PARTY', TXMLSUBMITTING_PARTYType);
  RegisterChildNode('REQUEST', TXMLREQUESTType);
  inherited;
end;

function TXMLREQUEST_GROUP.Get_MISMOVersionID: WideString;
begin
  Result := AttributeNodes['MISMOVersionID'].Text;
end;

procedure TXMLREQUEST_GROUP.Set_MISMOVersionID(Value: WideString);
begin
  SetAttribute('MISMOVersionID', Value);
end;

function TXMLREQUEST_GROUP.Get_SUBMITTING_PARTY: IXMLSUBMITTING_PARTYType;
begin
  Result := ChildNodes['SUBMITTING_PARTY'] as IXMLSUBMITTING_PARTYType;
end;

function TXMLREQUEST_GROUP.Get_REQUEST: IXMLREQUESTType;
begin
  Result := ChildNodes['REQUEST'] as IXMLREQUESTType;
end;

{ TXMLSUBMITTING_PARTYType }

function TXMLSUBMITTING_PARTYType.Get__Name: WideString;
begin
  Result := AttributeNodes['_Name'].Text;
end;

procedure TXMLSUBMITTING_PARTYType.Set__Name(Value: WideString);
begin
  SetAttribute('_Name', Value);
end;

function TXMLSUBMITTING_PARTYType.Get__TransactionIdentifier: WideString;
begin
  Result := AttributeNodes['_TransactionIdentifier'].NodeValue;
end;

procedure TXMLSUBMITTING_PARTYType.Set__TransactionIdentifier(Value: WideString);
begin
  SetAttribute('_TransactionIdentifier', Value);
end;

{ TXMLREQUESTType }

procedure TXMLREQUESTType.AfterConstruction;
begin
  RegisterChildNode('REQUEST_DATA', TXMLREQUEST_DATAType);
  inherited;
end;

function TXMLREQUESTType.Get_REQUEST_DATA: IXMLREQUEST_DATAType;
begin
  Result := ChildNodes['REQUEST_DATA'] as IXMLREQUEST_DATAType;
end;

{ TXMLREQUEST_DATAType }

procedure TXMLREQUEST_DATAType.AfterConstruction;
begin
  RegisterChildNode('VALUATION_REQUEST', TXMLVALUATION_REQUESTType);
  inherited;
end;

function TXMLREQUEST_DATAType.Get_VALUATION_REQUEST: IXMLVALUATION_REQUESTType;
begin
  Result := ChildNodes['VALUATION_REQUEST'] as IXMLVALUATION_REQUESTType;
end;

{ TXMLVALUATION_REQUESTType }

procedure TXMLVALUATION_REQUESTType.AfterConstruction;
begin
  RegisterChildNode('SERVICE_PAYMENT', TXMLSERVICE_PAYMENT);
  RegisterChildNode('LOAN', TXMLLOANType);
  RegisterChildNode('_PRODUCT', TXML_PRODUCTType);
  RegisterChildNode('PARTIES', TXMLPARTIESType);
  RegisterChildNode('COMPLIANCE_GUIDELINE', TXMLCOMPLIANCE_GUIDELINEType);
  RegisterChildNode('SPECIAL_INSTRUCTIONS', TXMLSPECIAL_INSTRUCTIONSType);
  inherited;
end;

function TXMLVALUATION_REQUESTType.Get__RushIndicator: WideString;
begin
  Result := AttributeNodes['_RushIndicator'].Text;
end;

procedure TXMLVALUATION_REQUESTType.Set__RushIndicator(Value: WideString);
begin
  SetAttribute('_RushIndicator', Value);
end;

function TXMLVALUATION_REQUESTType.Get__CommentText: WideString;
begin
  Result := AttributeNodes['_CommentText'].Text;
end;

procedure TXMLVALUATION_REQUESTType.Set__CommentText(Value: WideString);
begin
  SetAttribute('_CommentText', Value);
end;

function TXMLVALUATION_REQUESTType.Get_SERVICE_PAYMENT: IXMLSERVICE_PAYMENT;
begin
  Result := ChildNodes['SERVICE_PAYMENT'] as IXMLSERVICE_PAYMENT;
end;

function TXMLVALUATION_REQUESTType.Get_LOAN: IXMLLOANType;
begin
  Result := ChildNodes['LOAN'] as IXMLLOANType;
end;

function TXMLVALUATION_REQUESTType.Get__PRODUCT: IXML_PRODUCTType;
begin
  Result := ChildNodes['_PRODUCT'] as IXML_PRODUCTType;
end;

function TXMLVALUATION_REQUESTType.Get_PARTIES: IXMLPARTIESType;
begin
  Result := ChildNodes['PARTIES'] as IXMLPARTIESType;
end;

function TXMLVALUATION_REQUESTType.Get_COMPLIANCE_GUIDELINE: IXMLCOMPLIANCE_GUIDELINEType;
begin
  Result := ChildNodes['COMPLIANCE_GUIDELINE'] as IXMLCOMPLIANCE_GUIDELINEType;
end;

function TXMLVALUATION_REQUESTType.Get_SPECIAL_INSTRUCTIONS: IXMLSPECIAL_INSTRUCTIONSType;
begin
  Result := ChildNodes['SPECIAL_INSTRUCTIONS'] as IXMLSPECIAL_INSTRUCTIONSType;
end;

{ TXMLSERVICE_PAYMENT }

{ TXMLLOANType }

procedure TXMLLOANType.AfterConstruction;
begin
  RegisterChildNode('_APPLICATION', TXML_APPLICATIONType);
  inherited;
end;

function TXMLLOANType.Get__APPLICATION: IXML_APPLICATIONType;
begin
  Result := ChildNodes['_APPLICATION'] as IXML_APPLICATIONType;
end;

{ TXML_APPLICATIONType }

procedure TXML_APPLICATIONType.AfterConstruction;
begin
  RegisterChildNode('LOAN_PURPOSE', TXMLLOAN_PURPOSEType);
  RegisterChildNode('MORTGAGE_TERMS', TXMLMORTGAGE_TERMSType);
  RegisterChildNode('PROPERTY', TXMLPROPERTYType);
  inherited;
end;

function TXML_APPLICATIONType.Get_LOAN_PURPOSE: IXMLLOAN_PURPOSEType;
begin
  Result := ChildNodes['LOAN_PURPOSE'] as IXMLLOAN_PURPOSEType;
end;

function TXML_APPLICATIONType.Get_MORTGAGE_TERMS: IXMLMORTGAGE_TERMSType;
begin
  Result := ChildNodes['MORTGAGE_TERMS'] as IXMLMORTGAGE_TERMSType;
end;

function TXML_APPLICATIONType.Get_PROPERTY_: IXMLPROPERTYType;
begin
  Result := ChildNodes['PROPERTY'] as IXMLPROPERTYType;
end;

{ TXMLLOAN_PURPOSEType }

function TXMLLOAN_PURPOSEType.Get__Type: WideString;
begin
  Result := AttributeNodes['_Type'].Text;
end;

procedure TXMLLOAN_PURPOSEType.Set__Type(Value: WideString);
begin
  SetAttribute('_Type', Value);
end;

{ TXMLMORTGAGE_TERMSType }

function TXMLMORTGAGE_TERMSType.Get_LenderCaseIdentifier: WideString;
begin
  Result := AttributeNodes['LenderCaseIdentifier'].Text;
end;

procedure TXMLMORTGAGE_TERMSType.Set_LenderCaseIdentifier(Value: WideString);
begin
  SetAttribute('LenderCaseIdentifier', Value);
end;

function TXMLMORTGAGE_TERMSType.Get_FHACaseIdentifier: WideString;
begin
  Result := AttributeNodes['FHACaseIdentifier'].Text;
end;

procedure TXMLMORTGAGE_TERMSType.Set_FHACaseIdentifier(Value: WideString);
begin
  SetAttribute('FHACaseIdentifier', Value);
end;

function TXMLMORTGAGE_TERMSType.Get_MortgageType: WideString;
begin
  Result := AttributeNodes['MortgageType'].Text;
end;

procedure TXMLMORTGAGE_TERMSType.Set_MortgageType(Value: WideString);
begin
  SetAttribute('MortgageType', Value);
end;

function TXMLMORTGAGE_TERMSType.Get_LoanAmount: WideString;
begin
  Result := AttributeNodes['LoanAmount'].Text;
end;

procedure TXMLMORTGAGE_TERMSType.Set_LoanAmount(Value: WideString);
begin
  SetAttribute('LoanAmount', Value);
end;

{ TXMLPROPERTYType }

procedure TXMLPROPERTYType.AfterConstruction;
begin
  RegisterChildNode('PARSED_STREET_ADDRESS', TXMLPARSED_STREET_ADDRESSType);
  RegisterChildNode('_IDENTIFICATION', TXML_IDENTIFICATION);
  RegisterChildNode('_LEGAL_DESCRIPTION', TXML_LEGAL_DESCRIPTIONType);
  RegisterChildNode('STRUCTURE', TXMLSTRUCTUREType);
  RegisterChildNode('_TAX', TXML_TAX);
  RegisterChildNode('SALES_HISTORY', TXMLSALES_HISTORYType);
  inherited;
end;

function TXMLPROPERTYType.Get_PropertyDescription: WideString;
begin
  Result := AttributeNodes['PropertyDescription'].Text;
end;

procedure TXMLPROPERTYType.Set_PropertyDescription(Value: WideString);
begin
  SetAttribute('PropertyDescription', Value);
end;

function TXMLPROPERTYType.Get__StreetAddress: WideString;
begin
  Result := AttributeNodes['_StreetAddress'].Text;
end;

procedure TXMLPROPERTYType.Set__StreetAddress(Value: WideString);
begin
  SetAttribute('_StreetAddress', Value);
end;

function TXMLPROPERTYType.Get__UnitNo: WideString;
begin
  Result := AttributeNodes['_UnitNo'].Text;
end;

procedure TXMLPROPERTYType.Set__UnitNo(Value: WideString);
begin
  SetAttribute('_UnitNo', Value);
end;

function TXMLPROPERTYType.Get__City: WideString;
begin
  Result := AttributeNodes['_City'].Text;
end;

procedure TXMLPROPERTYType.Set__City(Value: WideString);
begin
  SetAttribute('_City', Value);
end;

function TXMLPROPERTYType.Get__State: WideString;
begin
  Result := AttributeNodes['_State'].Text;
end;

procedure TXMLPROPERTYType.Set__State(Value: WideString);
begin
  SetAttribute('_State', Value);
end;

function TXMLPROPERTYType.Get__County: WideString;
begin
  Result := AttributeNodes['_County'].Text;
end;

procedure TXMLPROPERTYType.Set__County(Value: WideString);
begin
  SetAttribute('_County', Value);
end;

function TXMLPROPERTYType.Get__PostalCode: WideString;
begin
  Result := AttributeNodes['_PostalCode'].Text;
end;

procedure TXMLPROPERTYType.Set__PostalCode(Value: WideString);
begin
  SetAttribute('_PostalCode', Value);
end;

function TXMLPROPERTYType.Get__CurrentOccupancyType: WideString;
begin
  Result := AttributeNodes['_CurrentOccupancyType'].Text;
end;

procedure TXMLPROPERTYType.Set__CurrentOccupancyType(Value: WideString);
begin
  SetAttribute('_CurrentOccupancyType', Value);
end;

function TXMLPROPERTYType.Get__StreetAddress2: WideString;
begin
  Result := AttributeNodes['_StreetAddress2'].Text;
end;

procedure TXMLPROPERTYType.Set__StreetAddress2(Value: WideString);
begin
  SetAttribute('_StreetAddress2', Value);
end;

function TXMLPROPERTYType.Get__YearBuilt: WideString;
begin
  Result := AttributeNodes['_YearBuilt'].Text;
end;

procedure TXMLPROPERTYType.Set__YearBuilt(Value: WideString);
begin
  SetAttribute('_YearBuilt', Value);
end;

function TXMLPROPERTYType.Get_PARSED_STREET_ADDRESS: IXMLPARSED_STREET_ADDRESSType;
begin
  Result := ChildNodes['PARSED_STREET_ADDRESS'] as IXMLPARSED_STREET_ADDRESSType;
end;

function TXMLPROPERTYType.Get__IDENTIFICATION: IXML_IDENTIFICATION;
begin
  Result := ChildNodes['_IDENTIFICATION'] as IXML_IDENTIFICATION;
end;

function TXMLPROPERTYType.Get__LEGAL_DESCRIPTION: IXML_LEGAL_DESCRIPTIONType;
begin
  Result := ChildNodes['_LEGAL_DESCRIPTION'] as IXML_LEGAL_DESCRIPTIONType;
end;

function TXMLPROPERTYType.Get_STRUCTURE: IXMLSTRUCTUREType;
begin
  Result := ChildNodes['STRUCTURE'] as IXMLSTRUCTUREType;
end;

function TXMLPROPERTYType.Get__TAX: IXML_TAX;
begin
  Result := ChildNodes['_TAX'] as IXML_TAX;
end;

function TXMLPROPERTYType.Get_SALES_HISTORY: IXMLSALES_HISTORYType;
begin
  Result := ChildNodes['SALES_HISTORY'] as IXMLSALES_HISTORYType;
end;

{ TXMLPARSED_STREET_ADDRESSType }

function TXMLPARSED_STREET_ADDRESSType.Get__StreetName: WideString;
begin
  Result := AttributeNodes['_StreetName'].Text;
end;

procedure TXMLPARSED_STREET_ADDRESSType.Set__StreetName(Value: WideString);
begin
  SetAttribute('_StreetName', Value);
end;

{ TXML_IDENTIFICATION }

{ TXML_LEGAL_DESCRIPTIONType }

function TXML_LEGAL_DESCRIPTIONType.Get__TextDescription: WideString;
begin
  Result := AttributeNodes['_TextDescription'].Text;
end;

procedure TXML_LEGAL_DESCRIPTIONType.Set__TextDescription(Value: WideString);
begin
  SetAttribute('_TextDescription', Value);
end;

{ TXMLSTRUCTUREType }

function TXMLSTRUCTUREType.Get_BuildingStatusType: WideString;
begin
  Result := AttributeNodes['BuildingStatusType'].Text;
end;

procedure TXMLSTRUCTUREType.Set_BuildingStatusType(Value: WideString);
begin
  SetAttribute('BuildingStatusType', Value);
end;

function TXMLSTRUCTUREType.Get_PropertyCategoryType: WideString;
begin
  Result := AttributeNodes['PropertyCategoryType'].Text;
end;

procedure TXMLSTRUCTUREType.Set_PropertyCategoryType(Value: WideString);
begin
  SetAttribute('PropertyCategoryType', Value);
end;

{ TXML_TAX }

{ TXMLSALES_HISTORYType }

function TXMLSALES_HISTORYType.Get_PropertyEstValue: WideString;
begin
  Result := AttributeNodes['PropertyEstValue'].Text;
end;

procedure TXMLSALES_HISTORYType.Set_PropertyEstValue(Value: WideString);
begin
  SetAttribute('PropertyEstValue', Value);
end;

function TXMLSALES_HISTORYType.Get_PropertySalesAmount: WideString;
begin
  Result := AttributeNodes['PropertySalesAmount'].Text;
end;

procedure TXMLSALES_HISTORYType.Set_PropertySalesAmount(Value: WideString);
begin
  SetAttribute('PropertySalesAmount', Value);
end;

{ TXML_PRODUCTType }

procedure TXML_PRODUCTType.AfterConstruction;
begin
  RegisterChildNode('_NAME', TXML_NAMEType);
  inherited;
end;

function TXML_PRODUCTType.Get_ServiceRequestedCompletionDueDate: WideString;
begin
  Result := AttributeNodes['ServiceRequestedCompletionDueDate'].Text;
end;

procedure TXML_PRODUCTType.Set_ServiceRequestedCompletionDueDate(Value: WideString);
begin
  SetAttribute('ServiceRequestedCompletionDueDate', Value);
end;

function TXML_PRODUCTType.Get_ServiceRequestedPriceAmount: WideString;
begin
  Result := AttributeNodes['ServiceRequestedPriceAmount'].Text;
end;

procedure TXML_PRODUCTType.Set_ServiceRequestedPriceAmount(Value: WideString);
begin
  SetAttribute('ServiceRequestedPriceAmount', Value);
end;

function TXML_PRODUCTType.Get__NAME: IXML_NAMEType;
begin
  Result := ChildNodes['_NAME'] as IXML_NAMEType;
end;

{ TXML_NAMEType }

procedure TXML_NAMEType.AfterConstruction;
begin
  RegisterChildNode('_ADDON', TXML_ADDONType);
  ItemTag := '_ADDON';
  ItemInterface := IXML_ADDONType;
  inherited;
end;

function TXML_NAMEType.Get__Description: WideString;
begin
  Result := AttributeNodes['_Description'].Text;
end;

procedure TXML_NAMEType.Set__Description(Value: WideString);
begin
  SetAttribute('_Description', Value);
end;

function TXML_NAMEType.Get__ADDON(Index: Integer): IXML_ADDONType;
begin
  Result := List[Index] as IXML_ADDONType;
end;

function TXML_NAMEType.Add: IXML_ADDONType;
begin
  Result := AddItem(-1) as IXML_ADDONType;
end;

function TXML_NAMEType.Insert(const Index: Integer): IXML_ADDONType;
begin
  Result := AddItem(Index) as IXML_ADDONType;
end;

{ TXML_ADDONType }

function TXML_ADDONType.Get__Type: WideString;
begin
  Result := AttributeNodes['_Type'].Text;
end;

procedure TXML_ADDONType.Set__Type(Value: WideString);
begin
  SetAttribute('_Type', Value);
end;

function TXML_ADDONType.Get__AddOnServiceDescription: WideString;
begin
  Result := AttributeNodes['_AddOnServiceDescription'].Text;
end;

procedure TXML_ADDONType.Set__AddOnServiceDescription(Value: WideString);
begin
  SetAttribute('_AddOnServiceDescription', Value);
end;

function TXML_ADDONType.Get__AddOnServicePriceAmount: WideString;
begin
  Result := AttributeNodes['_AddOnServicePriceAmount'].Text;
end;

procedure TXML_ADDONType.Set__AddOnServicePriceAmount(Value: WideString);
begin
  SetAttribute('_AddOnServicePriceAmount', Value);
end;

{ TXMLPARTIESType }

procedure TXMLPARTIESType.AfterConstruction;
begin
  RegisterChildNode('APPRAISER', TXMLAPPRAISERType);
  RegisterChildNode('LENDER', TXMLLENDERType);
  RegisterChildNode('BORROWER', TXMLBORROWERType);
  FBORROWER := CreateCollection(TXMLBORROWERTypeList, IXMLBORROWERType, 'BORROWER') as IXMLBORROWERTypeList;
  inherited;
end;

function TXMLPARTIESType.Get_APPRAISER: IXMLAPPRAISERType;
begin
  Result := ChildNodes['APPRAISER'] as IXMLAPPRAISERType;
end;

function TXMLPARTIESType.Get_LENDER: IXMLLENDERType;
begin
  Result := ChildNodes['LENDER'] as IXMLLENDERType;
end;

function TXMLPARTIESType.Get_BORROWER: IXMLBORROWERTypeList;
begin
  Result := FBORROWER;
end;

{ TXMLAPPRAISERType }

function TXMLAPPRAISERType.Get__Identifier: WideString;
begin
  Result := AttributeNodes['_Identifier'].Text;
end;

procedure TXMLAPPRAISERType.Set__Identifier(Value: WideString);
begin
  SetAttribute('_Identifier', Value);
end;

function TXMLAPPRAISERType.Get__Name: WideString;
begin
  Result := AttributeNodes['_Name'].Text;
end;

procedure TXMLAPPRAISERType.Set__Name(Value: WideString);
begin
  SetAttribute('_Name', Value);
end;

function TXMLAPPRAISERType.Get__Phone: WideString;
begin
  Result := AttributeNodes['_Phone'].Text;
end;

procedure TXMLAPPRAISERType.Set__Phone(Value: WideString);
begin
  SetAttribute('_Phone', Value);
end;

function TXMLAPPRAISERType.Get__Fax: WideString;
begin
  Result := AttributeNodes['_Fax'].Text;
end;

procedure TXMLAPPRAISERType.Set__Fax(Value: WideString);
begin
  SetAttribute('_Fax', Value);
end;

{ TXMLLENDERType }

function TXMLLENDERType.Get__City: WideString;
begin
  Result := AttributeNodes['_City'].Text;
end;

procedure TXMLLENDERType.Set__City(Value: WideString);
begin
  SetAttribute('_City', Value);
end;

function TXMLLENDERType.Get__UnparsedName: WideString;
begin
  Result := AttributeNodes['_UnparsedName'].Text;
end;

procedure TXMLLENDERType.Set__UnparsedName(Value: WideString);
begin
  SetAttribute('_UnparsedName', Value);
end;

function TXMLLENDERType.Get__StreetAddress: WideString;
begin
  Result := AttributeNodes['_StreetAddress'].Text;
end;

procedure TXMLLENDERType.Set__StreetAddress(Value: WideString);
begin
  SetAttribute('_StreetAddress', Value);
end;

function TXMLLENDERType.Get__State: WideString;
begin
  Result := AttributeNodes['_State'].Text;
end;

procedure TXMLLENDERType.Set__State(Value: WideString);
begin
  SetAttribute('_State', Value);
end;

function TXMLLENDERType.Get__PostalCode: WideString;
begin
  Result := AttributeNodes['_PostalCode'].Text;
end;

procedure TXMLLENDERType.Set__PostalCode(Value: WideString);
begin
  SetAttribute('_PostalCode', Value);
end;

function TXMLLENDERType.Get__Phone: WideString;
begin
  Result := AttributeNodes['_Phone'].Text;
end;

procedure TXMLLENDERType.Set__Phone(Value: WideString);
begin
  SetAttribute('_Phone', Value);
end;

function TXMLLENDERType.Get__Fax: WideString;
begin
  Result := AttributeNodes['_Fax'].Text;
end;

procedure TXMLLENDERType.Set__Fax(Value: WideString);
begin
  SetAttribute('_Fax', Value);
end;

function TXMLLENDERType.Get__Email: WideString;
begin
  Result := AttributeNodes['_Email'].Text;
end;

procedure TXMLLENDERType.Set__Email(Value: WideString);
begin
  SetAttribute('_Email', Value);
end;

{ TXMLBORROWERType }

procedure TXMLBORROWERType.AfterConstruction;
begin
  RegisterChildNode('CONTACT_DETAIL', TXMLCONTACT_DETAILType);
  inherited;
end;

function TXMLBORROWERType.Get__PrintPositionType: WideString;
begin
  Result := AttributeNodes['_PrintPositionType'].Text;
end;

procedure TXMLBORROWERType.Set__PrintPositionType(Value: WideString);
begin
  SetAttribute('_PrintPositionType', Value);
end;

function TXMLBORROWERType.Get__LastName: WideString;
begin
  Result := AttributeNodes['_LastName'].Text;
end;

procedure TXMLBORROWERType.Set__LastName(Value: WideString);
begin
  SetAttribute('_LastName', Value);
end;

function TXMLBORROWERType.Get__FirstName: WideString;
begin
  Result := AttributeNodes['_FirstName'].Text;
end;

procedure TXMLBORROWERType.Set__FirstName(Value: WideString);
begin
  SetAttribute('_FirstName', Value);
end;

function TXMLBORROWERType.Get_CONTACT_DETAIL: IXMLCONTACT_DETAILType;
begin
  Result := ChildNodes['CONTACT_DETAIL'] as IXMLCONTACT_DETAILType;
end;

{ TXMLBORROWERTypeList }

function TXMLBORROWERTypeList.Add: IXMLBORROWERType;
begin
  Result := AddItem(-1) as IXMLBORROWERType;
end;

function TXMLBORROWERTypeList.Insert(const Index: Integer): IXMLBORROWERType;
begin
  Result := AddItem(Index) as IXMLBORROWERType;
end;
function TXMLBORROWERTypeList.Get_Item(Index: Integer): IXMLBORROWERType;
begin
  Result := List[Index] as IXMLBORROWERType;
end;

{ TXMLCONTACT_DETAILType }

procedure TXMLCONTACT_DETAILType.AfterConstruction;
begin
  RegisterChildNode('CONTACT_POINT', TXMLCONTACT_POINTType);
  ItemTag := 'CONTACT_POINT';
  ItemInterface := IXMLCONTACT_POINTType;
  inherited;
end;

function TXMLCONTACT_DETAILType.Get_CONTACT_POINT(Index: Integer): IXMLCONTACT_POINTType;
begin
  Result := List[Index] as IXMLCONTACT_POINTType;
end;

function TXMLCONTACT_DETAILType.Add: IXMLCONTACT_POINTType;
begin
  Result := AddItem(-1) as IXMLCONTACT_POINTType;
end;

function TXMLCONTACT_DETAILType.Insert(const Index: Integer): IXMLCONTACT_POINTType;
begin
  Result := AddItem(Index) as IXMLCONTACT_POINTType;
end;

{ TXMLCONTACT_POINTType }

function TXMLCONTACT_POINTType.Get__Type: WideString;
begin
  Result := AttributeNodes['_Type'].Text;
end;

procedure TXMLCONTACT_POINTType.Set__Type(Value: WideString);
begin
  SetAttribute('_Type', Value);
end;

function TXMLCONTACT_POINTType.Get__RoleType: WideString;
begin
  Result := AttributeNodes['_RoleType'].Text;
end;

procedure TXMLCONTACT_POINTType.Set__RoleType(Value: WideString);
begin
  SetAttribute('_RoleType', Value);
end;

function TXMLCONTACT_POINTType.Get__Value: WideString;
begin
  Result := AttributeNodes['_Value'].Text;
end;

procedure TXMLCONTACT_POINTType.Set__Value(Value: WideString);
begin
  SetAttribute('_Value', Value);
end;

{ TXMLCOMPLIANCE_GUIDELINEType }

procedure TXMLCOMPLIANCE_GUIDELINEType.AfterConstruction;
begin
  RegisterChildNode('GUIDELINE', TXMLGUIDELINEType);
  ItemTag := 'GUIDELINE';
  ItemInterface := IXMLGUIDELINEType;
  inherited;
end;

function TXMLCOMPLIANCE_GUIDELINEType.Get_GUIDELINE(Index: Integer): IXMLGUIDELINEType;
begin
  Result := List[Index] as IXMLGUIDELINEType;
end;

function TXMLCOMPLIANCE_GUIDELINEType.Add: IXMLGUIDELINEType;
begin
  Result := AddItem(-1) as IXMLGUIDELINEType;
end;

function TXMLCOMPLIANCE_GUIDELINEType.Insert(const Index: Integer): IXMLGUIDELINEType;
begin
  Result := AddItem(Index) as IXMLGUIDELINEType;
end;

{ TXMLGUIDELINEType }

function TXMLGUIDELINEType.Get__SequenceIdentifier: WideString;
begin
  Result := AttributeNodes['_SequenceIdentifier'].Text;
end;

procedure TXMLGUIDELINEType.Set__SequenceIdentifier(Value: WideString);
begin
  SetAttribute('_SequenceIdentifier', Value);
end;

function TXMLGUIDELINEType.Get__Description: WideString;
begin
  Result := AttributeNodes['_Description'].Text;
end;

procedure TXMLGUIDELINEType.Set__Description(Value: WideString);
begin
  SetAttribute('_Description', Value);
end;

{ TXMLSPECIAL_INSTRUCTIONSType }

procedure TXMLSPECIAL_INSTRUCTIONSType.AfterConstruction;
begin
  RegisterChildNode('INSTRUCTION', TXMLINSTRUCTIONType);
  ItemTag := 'INSTRUCTION';
  ItemInterface := IXMLINSTRUCTIONType;
  inherited;
end;

function TXMLSPECIAL_INSTRUCTIONSType.Get_INSTRUCTION(Index: Integer): IXMLINSTRUCTIONType;
begin
  Result := List[Index] as IXMLINSTRUCTIONType;
end;

function TXMLSPECIAL_INSTRUCTIONSType.Add: IXMLINSTRUCTIONType;
begin
  Result := AddItem(-1) as IXMLINSTRUCTIONType;
end;

function TXMLSPECIAL_INSTRUCTIONSType.Insert(const Index: Integer): IXMLINSTRUCTIONType;
begin
  Result := AddItem(Index) as IXMLINSTRUCTIONType;
end;

{ TXMLINSTRUCTIONType }

function TXMLINSTRUCTIONType.Get__SequenceIdentifier: WideString;
begin
  Result := AttributeNodes['_SequenceIdentifier'].Text;
end;

procedure TXMLINSTRUCTIONType.Set__SequenceIdentifier(Value: WideString);
begin
  SetAttribute('_SequenceIdentifier', Value);
end;

function TXMLINSTRUCTIONType.Get__Description: WideString;
begin
  Result := AttributeNodes['_Description'].Text;
end;

procedure TXMLINSTRUCTIONType.Set__Description(Value: WideString);
begin
  SetAttribute('_Description', Value);
end;

end.