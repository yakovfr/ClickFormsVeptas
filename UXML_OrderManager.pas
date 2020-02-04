
{*************************************************************************************************}
{                                                                                                 }
{                                        XML Data Binding                                         }
{                                                                                                 }
{         Generated on: 1/27/2018 10:01:42 AM                                                     }
{       Generated from: C:\Users\ClfBuilder\Documents\My ClickFORMS\Exports\XMLOrderManager.xml   }
{   Settings stored in: C:\Users\ClfBuilder\Documents\My ClickFORMS\Exports\XMLOrderManager.xdb   }
{                                                                                                 }
{*************************************************************************************************}

unit UXML_OrderManager;

interface

uses xmldom, XMLDoc, XMLIntf, SysUtils, Variants;

type

{ Forward Decls }

  IXMLOrderManagementServicesType = interface;
  IXMLGetVendorListCFType = interface;
  IXMLResultType = interface;
  IXMLResponseDataType = interface;
  IXMLGetvendorlistcf_responseType = interface;
  IXMLVendorsType = interface;
  IXMLVendorType = interface;
  IXMLGetstatuslistcf_responseType = interface;
  IXMLStatusesType = interface;
  IXMLStatusType = interface;
  IXMLGetorderlistcf_responseType = interface;
  IXMLOrdersType = interface;
  IXMLOrderType = interface;
  IXMLGetorderdetailcf_responseType = interface;
  IXMLGetStatusListCFType = interface;
  IXMLGetOrderListCFType = interface;
  IXMLGetOrderDetailCFType = interface;

{ IXMLOrderManagementServicesType }

  IXMLOrderManagementServicesType = interface(IXMLNode)
    ['{9684A06A-B76E-4186-88CE-172B22C14A1E}']
    { Property Accessors }
    function Get_GetVendorListCF: IXMLGetVendorListCFType;
    function Get_GetStatusListCF: IXMLGetStatusListCFType;
    function Get_GetOrderListCF: IXMLGetOrderListCFType;
    function Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
    { Methods & Properties }
    property GetVendorListCF: IXMLGetVendorListCFType read Get_GetVendorListCF;
    property GetStatusListCF: IXMLGetStatusListCFType read Get_GetStatusListCF;
    property GetOrderListCF: IXMLGetOrderListCFType read Get_GetOrderListCF;
    property GetOrderDetailCF: IXMLGetOrderDetailCFType read Get_GetOrderDetailCF;
  end;

{ IXMLGetVendorListCFType }

  IXMLGetVendorListCFType = interface(IXMLNode)
    ['{B73A1A31-76B3-4829-ACEF-DF4009BFEE2D}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ IXMLResultType }

  IXMLResultType = interface(IXMLNode)
    ['{AF990E59-77F2-444B-8A54-61CD40ADCD10}']
    { Property Accessors }
    function Get_Code: Integer;
    function Get_Type_: WideString;
    function Get_Description: WideString;
    procedure Set_Code(Value: Integer);
    procedure Set_Type_(Value: WideString);
    procedure Set_Description(Value: WideString);
    { Methods & Properties }
    property Code: Integer read Get_Code write Set_Code;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Description: WideString read Get_Description write Set_Description;
  end;

{ IXMLResponseDataType }

  IXMLResponseDataType = interface(IXMLNode)
    ['{D62118B0-205D-4628-ACC3-C782F40BC140}']
    { Property Accessors }
    function Get_Getvendorlistcf_response: IXMLGetvendorlistcf_responseType;
    function Get_Getstatuslistcf_response: IXMLGetstatuslistcf_responseType;
    function Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
    function Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
    { Methods & Properties }
    property Getvendorlistcf_response: IXMLGetvendorlistcf_responseType read Get_Getvendorlistcf_response;
    property Getstatuslistcf_response: IXMLGetstatuslistcf_responseType read Get_Getstatuslistcf_response;
    property Getorderlistcf_response: IXMLGetorderlistcf_responseType read Get_Getorderlistcf_response;
    property Getorderdetailcf_response: IXMLGetorderdetailcf_responseType read Get_Getorderdetailcf_response;
  end;

{ IXMLGetvendorlistcf_responseType }

  IXMLGetvendorlistcf_responseType = interface(IXMLNode)
    ['{20934B32-0AEC-42C4-9817-4F15B2F762CF}']
    { Property Accessors }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Vendors: IXMLVendorsType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
    { Methods & Properties }
    property Status: Integer read Get_Status write Set_Status;
    property Count: Integer read Get_Count write Set_Count;
    property Vendors: IXMLVendorsType read Get_Vendors;
  end;

{ IXMLVendorsType }

  IXMLVendorsType = interface(IXMLNodeCollection)
    ['{DC2B2C76-20AB-4F48-9360-83C645FC12DB}']
    { Property Accessors }
    function Get_Vendor(Index: Integer): IXMLVendorType;
    { Methods & Properties }
    function Add: IXMLVendorType;
    function Insert(const Index: Integer): IXMLVendorType;
    property Vendor[Index: Integer]: IXMLVendorType read Get_Vendor; default;
  end;

{ IXMLVendorType }

  IXMLVendorType = interface(IXMLNode)
    ['{E341D52B-AEDC-4BB6-9CD4-82FAE93B8CFC}']
    { Property Accessors }
    function Get_Vendor_name: WideString;
    procedure Set_Vendor_name(Value: WideString);
    { Methods & Properties }
    property Vendor_name: WideString read Get_Vendor_name write Set_Vendor_name;
  end;

{ IXMLGetstatuslistcf_responseType }

  IXMLGetstatuslistcf_responseType = interface(IXMLNode)
    ['{35522E9B-DE4F-47D5-9B19-B03D1C253C70}']
    { Property Accessors }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Statuses: IXMLStatusesType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
    { Methods & Properties }
    property Status: Integer read Get_Status write Set_Status;
    property Count: Integer read Get_Count write Set_Count;
    property Statuses: IXMLStatusesType read Get_Statuses;
  end;

{ IXMLStatusesType }

  IXMLStatusesType = interface(IXMLNodeCollection)
    ['{22C44994-7A32-48D0-9840-A2710CCB67F1}']
    { Property Accessors }
    function Get_Status(Index: Integer): IXMLStatusType;
    { Methods & Properties }
    function Add: IXMLStatusType;
    function Insert(const Index: Integer): IXMLStatusType;
    property Status[Index: Integer]: IXMLStatusType read Get_Status; default;
  end;

{ IXMLStatusType }

  IXMLStatusType = interface(IXMLNode)
    ['{6E2C2BC2-4E9C-4E1C-93EE-5F651D22B7D2}']
    { Property Accessors }
    function Get_Status_id: Integer;
    function Get_Status_name: WideString;
    procedure Set_Status_id(Value: Integer);
    procedure Set_Status_name(Value: WideString);
    { Methods & Properties }
    property Status_id: Integer read Get_Status_id write Set_Status_id;
    property Status_name: WideString read Get_Status_name write Set_Status_name;
  end;

{ IXMLGetorderlistcf_responseType }

  IXMLGetorderlistcf_responseType = interface(IXMLNode)
    ['{3E1A7FC7-205A-49AE-8E95-47FF167F9791}']
    { Property Accessors }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Orders: IXMLOrdersType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
    { Methods & Properties }
    property Status: Integer read Get_Status write Set_Status;
    property Count: Integer read Get_Count write Set_Count;
    property Orders: IXMLOrdersType read Get_Orders;
  end;

{ IXMLOrdersType }

  IXMLOrdersType = interface(IXMLNodeCollection)
    ['{88DA0368-16FF-4423-8E7C-26BE21ABC6C7}']
    { Property Accessors }
    function Get_Order(Index: Integer): IXMLOrderType;
    { Methods & Properties }
    function Add: IXMLOrderType;
    function Insert(const Index: Integer): IXMLOrderType;
    property Order[Index: Integer]: IXMLOrderType read Get_Order; default;
  end;

{ IXMLOrderType }

  IXMLOrderType = interface(IXMLNode)
    ['{7E77F5B4-E752-4D5A-8D5A-BCBF5944CFB7}']
    { Property Accessors }
    function Get_Appraisal_order_id: Integer;
    function Get_Appraisal_type_name: WideString;
    function Get_Appraisal_status_name: WideString;
    function Get_Appraisal_received_date: WideString;
    function Get_Appraisal_accept_date: WideString;
    function Get_Appraisal_due_date: WideString;
    function Get_Requestor_company_name: WideString;
    function Get_Requestor_firstname: WideString;
    function Get_Requestor_lastname: WideString;
    function Get_Requestor_address: WideString;
    function Get_Appraisal_amount_invoiced: Integer;
    function Get_Appraisal_amount_paid: Integer;
    function Get_Appraisal_order_reference: WideString;
    function Get_Vendor_name: WideString;
    function Get_Appraisal_type: WideString;
    function Get_Appraisal_purpose: WideString;
    function Get_Appraisal_payment_method: WideString;
    function Get_Appraisal_delivery_method: WideString;
    function Get_Appraisal_order_owner: WideString;
    function Get_Appraisal_fha_number: WideString;
    function Get_Appraisal_comment: WideString;
    function Get_Appraisal_other_purpose: WideString;
    function Get_Appraisal_other_type: WideString;
    function Get_Appraisal_requested_due_date: WideString;
    function Get_Requestor_address2: WideString;
    function Get_Requestor_city: WideString;
    function Get_Requestor_state: WideString;
    function Get_Requestor_zip: WideString;
    function Get_Requestor_phone: WideString;
    function Get_Requestor_extension: WideString;
    function Get_Requestor_fax: WideString;
    function Get_Requestor_email: WideString;
    function Get_Lender_name: WideString;
    function Get_Lender_loan_number: WideString;
    function Get_Lender_value_estimate: WideString;
    function Get_Lender_loan_amount: WideString;
    function Get_Lender_borrower_lastname: WideString;
    function Get_Lender_borrower_firstname: WideString;
    function Get_Lender_loan_to_value: Integer;
    function Get_Property_type: WideString;
    function Get_Property_address: WideString;
    function Get_Property_city: WideString;
    function Get_Property_state: WideString;
    function Get_Property__total_rooms: Integer;
    function Get_Property_bedrooms: Integer;
    function Get_Property_baths: WideString;
    function Get_Property_zipcode: WideString;
    function Get_Property_comment: WideString;
    function Get_Occupancy_other_comment: WideString;
    function Get_Vendor_raw_data: WideString;
    function Get_Sub_status_id: Integer;
    function Get_Scheduled_date: WideString;
    function Get_Inspection_completed_date: WideString;
    function Get_Delayed_datetime: WideString;
    procedure Set_Appraisal_order_id(Value: Integer);
    procedure Set_Appraisal_type_name(Value: WideString);
    procedure Set_Appraisal_status_name(Value: WideString);
    procedure Set_Appraisal_received_date(Value: WideString);
    procedure Set_Appraisal_accept_date(Value: WideString);
    procedure Set_Appraisal_due_date(Value: WideString);
    procedure Set_Requestor_company_name(Value: WideString);
    procedure Set_Requestor_firstname(Value: WideString);
    procedure Set_Requestor_lastname(Value: WideString);
    procedure Set_Requestor_address(Value: WideString);
    procedure Set_Appraisal_amount_invoiced(Value: Integer);
    procedure Set_Appraisal_amount_paid(Value: Integer);
    procedure Set_Appraisal_order_reference(Value: WideString);
    procedure Set_Vendor_name(Value: WideString);
    procedure Set_Appraisal_type(Value: WideString);
    procedure Set_Appraisal_purpose(Value: WideString);
    procedure Set_Appraisal_payment_method(Value: WideString);
    procedure Set_Appraisal_delivery_method(Value: WideString);
    procedure Set_Appraisal_order_owner(Value: WideString);
    procedure Set_Appraisal_fha_number(Value: WideString);
    procedure Set_Appraisal_comment(Value: WideString);
    procedure Set_Appraisal_other_purpose(Value: WideString);
    procedure Set_Appraisal_other_type(Value: WideString);
    procedure Set_Appraisal_requested_due_date(Value: WideString);
    procedure Set_Requestor_address2(Value: WideString);
    procedure Set_Requestor_city(Value: WideString);
    procedure Set_Requestor_state(Value: WideString);
    procedure Set_Requestor_zip(Value: WideString);
    procedure Set_Requestor_phone(Value: WideString);
    procedure Set_Requestor_extension(Value: WideString);
    procedure Set_Requestor_fax(Value: WideString);
    procedure Set_Requestor_email(Value: WideString);
    procedure Set_Lender_name(Value: WideString);
    procedure Set_Lender_loan_number(Value: WideString);
    procedure Set_Lender_value_estimate(Value: WideString);
    procedure Set_Lender_loan_amount(Value: WideString);
    procedure Set_Lender_borrower_lastname(Value: WideString);
    procedure Set_Lender_borrower_firstname(Value: WideString);
    procedure Set_Lender_loan_to_value(Value: Integer);
    procedure Set_Property_type(Value: WideString);
    procedure Set_Property_address(Value: WideString);
    procedure Set_Property_city(Value: WideString);
    procedure Set_Property_state(Value: WideString);
    procedure Set_Property__total_rooms(Value: Integer);
    procedure Set_Property_bedrooms(Value: Integer);
    procedure Set_Property_baths(Value: WideString);
    procedure Set_Property_zipcode(Value: WideString);
    procedure Set_Property_comment(Value: WideString);
    procedure Set_Occupancy_other_comment(Value: WideString);
    procedure Set_Vendor_raw_data(Value: WideString);
    procedure Set_Sub_status_id(Value: Integer);
    procedure Set_Scheduled_date(Value: WideString);
    procedure Set_Inspection_completed_date(Value: WideString);
    procedure Set_Delayed_datetime(Value: WideString);
    { Methods & Properties }
    property Appraisal_order_id: Integer read Get_Appraisal_order_id write Set_Appraisal_order_id;
    property Appraisal_type_name: WideString read Get_Appraisal_type_name write Set_Appraisal_type_name;
    property Appraisal_status_name: WideString read Get_Appraisal_status_name write Set_Appraisal_status_name;
    property Appraisal_received_date: WideString read Get_Appraisal_received_date write Set_Appraisal_received_date;
    property Appraisal_accept_date: WideString read Get_Appraisal_accept_date write Set_Appraisal_accept_date;
    property Appraisal_due_date: WideString read Get_Appraisal_due_date write Set_Appraisal_due_date;
    property Requestor_company_name: WideString read Get_Requestor_company_name write Set_Requestor_company_name;
    property Requestor_firstname: WideString read Get_Requestor_firstname write Set_Requestor_firstname;
    property Requestor_lastname: WideString read Get_Requestor_lastname write Set_Requestor_lastname;
    property Requestor_address: WideString read Get_Requestor_address write Set_Requestor_address;
    property Appraisal_amount_invoiced: Integer read Get_Appraisal_amount_invoiced write Set_Appraisal_amount_invoiced;
    property Appraisal_amount_paid: Integer read Get_Appraisal_amount_paid write Set_Appraisal_amount_paid;
    property Appraisal_order_reference: WideString read Get_Appraisal_order_reference write Set_Appraisal_order_reference;
    property Vendor_name: WideString read Get_Vendor_name write Set_Vendor_name;
    property Appraisal_type: WideString read Get_Appraisal_type write Set_Appraisal_type;
    property Appraisal_purpose: WideString read Get_Appraisal_purpose write Set_Appraisal_purpose;
    property Appraisal_payment_method: WideString read Get_Appraisal_payment_method write Set_Appraisal_payment_method;
    property Appraisal_delivery_method: WideString read Get_Appraisal_delivery_method write Set_Appraisal_delivery_method;
    property Appraisal_order_owner: WideString read Get_Appraisal_order_owner write Set_Appraisal_order_owner;
    property Appraisal_fha_number: WideString read Get_Appraisal_fha_number write Set_Appraisal_fha_number;
    property Appraisal_comment: WideString read Get_Appraisal_comment write Set_Appraisal_comment;
    property Appraisal_other_purpose: WideString read Get_Appraisal_other_purpose write Set_Appraisal_other_purpose;
    property Appraisal_other_type: WideString read Get_Appraisal_other_type write Set_Appraisal_other_type;
    property Appraisal_requested_due_date: WideString read Get_Appraisal_requested_due_date write Set_Appraisal_requested_due_date;
    property Requestor_address2: WideString read Get_Requestor_address2 write Set_Requestor_address2;
    property Requestor_city: WideString read Get_Requestor_city write Set_Requestor_city;
    property Requestor_state: WideString read Get_Requestor_state write Set_Requestor_state;
    property Requestor_zip: WideString read Get_Requestor_zip write Set_Requestor_zip;
    property Requestor_phone: WideString read Get_Requestor_phone write Set_Requestor_phone;
    property Requestor_extension: WideString read Get_Requestor_extension write Set_Requestor_extension;
    property Requestor_fax: WideString read Get_Requestor_fax write Set_Requestor_fax;
    property Requestor_email: WideString read Get_Requestor_email write Set_Requestor_email;
    property Lender_name: WideString read Get_Lender_name write Set_Lender_name;
    property Lender_loan_number: WideString read Get_Lender_loan_number write Set_Lender_loan_number;
    property Lender_value_estimate: WideString read Get_Lender_value_estimate write Set_Lender_value_estimate;
    property Lender_loan_amount: WideString read Get_Lender_loan_amount write Set_Lender_loan_amount;
    property Lender_borrower_lastname: WideString read Get_Lender_borrower_lastname write Set_Lender_borrower_lastname;
    property Lender_borrower_firstname: WideString read Get_Lender_borrower_firstname write Set_Lender_borrower_firstname;
    property Lender_loan_to_value: Integer read Get_Lender_loan_to_value write Set_Lender_loan_to_value;
    property Property_type: WideString read Get_Property_type write Set_Property_type;
    property Property_address: WideString read Get_Property_address write Set_Property_address;
    property Property_city: WideString read Get_Property_city write Set_Property_city;
    property Property_state: WideString read Get_Property_state write Set_Property_state;
    property Property__total_rooms: Integer read Get_Property__total_rooms write Set_Property__total_rooms;
    property Property_bedrooms: Integer read Get_Property_bedrooms write Set_Property_bedrooms;
    property Property_baths: WideString read Get_Property_baths write Set_Property_baths;
    property Property_zipcode: WideString read Get_Property_zipcode write Set_Property_zipcode;
    property Property_comment: WideString read Get_Property_comment write Set_Property_comment;
    property Occupancy_other_comment: WideString read Get_Occupancy_other_comment write Set_Occupancy_other_comment;
    property Vendor_raw_data: WideString read Get_Vendor_raw_data write Set_Vendor_raw_data;
    property Sub_status_id: Integer read Get_Sub_status_id write Set_Sub_status_id;
    property Scheduled_date: WideString read Get_Scheduled_date write Set_Scheduled_date;
    property Inspection_completed_date: WideString read Get_Inspection_completed_date write Set_Inspection_completed_date;
    property Delayed_datetime: WideString read Get_Delayed_datetime write Set_Delayed_datetime;
  end;

{ IXMLGetorderdetailcf_responseType }

  IXMLGetorderdetailcf_responseType = interface(IXMLNode)
    ['{E3BB8C78-C3AE-4AB2-8343-DE61B9EB24F0}']
    { Property Accessors }
    function Get_Status: Integer;
    function Get_Access_token: WideString;
    function Get_Order: IXMLOrderType;
    procedure Set_Status(Value: Integer);
    procedure Set_Access_token(Value: WideString);
    { Methods & Properties }
    property Status: Integer read Get_Status write Set_Status;
    property Access_token: WideString read Get_Access_token write Set_Access_token;
    property Order: IXMLOrderType read Get_Order;
  end;

{ IXMLGetStatusListCFType }

  IXMLGetStatusListCFType = interface(IXMLNode)
    ['{0518FE26-9949-428B-9BBF-5FEE81DD3B0B}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ IXMLGetOrderListCFType }

  IXMLGetOrderListCFType = interface(IXMLNode)
    ['{44A5D79B-66C2-4729-B3C6-145907F1A889}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ IXMLGetOrderDetailCFType }

  IXMLGetOrderDetailCFType = interface(IXMLNode)
    ['{EA94BE7B-069D-4B0F-8154-C50F35A4C6B2}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ Forward Decls }

  TXMLOrderManagementServicesType = class;
  TXMLGetVendorListCFType = class;
  TXMLResultType = class;
  TXMLResponseDataType = class;
  TXMLGetvendorlistcf_responseType = class;
  TXMLVendorsType = class;
  TXMLVendorType = class;
  TXMLGetstatuslistcf_responseType = class;
  TXMLStatusesType = class;
  TXMLStatusType = class;
  TXMLGetorderlistcf_responseType = class;
  TXMLOrdersType = class;
  TXMLOrderType = class;
  TXMLGetorderdetailcf_responseType = class;
  TXMLGetStatusListCFType = class;
  TXMLGetOrderListCFType = class;
  TXMLGetOrderDetailCFType = class;

{ TXMLOrderManagementServicesType }

  TXMLOrderManagementServicesType = class(TXMLNode, IXMLOrderManagementServicesType)
  protected
    { IXMLOrderManagementServicesType }
    function Get_GetVendorListCF: IXMLGetVendorListCFType;
    function Get_GetStatusListCF: IXMLGetStatusListCFType;
    function Get_GetOrderListCF: IXMLGetOrderListCFType;
    function Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGetVendorListCFType }

  TXMLGetVendorListCFType = class(TXMLNode, IXMLGetVendorListCFType)
  protected
    { IXMLGetVendorListCFType }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLResultType }

  TXMLResultType = class(TXMLNode, IXMLResultType)
  protected
    { IXMLResultType }
    function Get_Code: Integer;
    function Get_Type_: WideString;
    function Get_Description: WideString;
    procedure Set_Code(Value: Integer);
    procedure Set_Type_(Value: WideString);
    procedure Set_Description(Value: WideString);
  end;

{ TXMLResponseDataType }

  TXMLResponseDataType = class(TXMLNode, IXMLResponseDataType)
  protected
    { IXMLResponseDataType }
    function Get_Getvendorlistcf_response: IXMLGetvendorlistcf_responseType;
    function Get_Getstatuslistcf_response: IXMLGetstatuslistcf_responseType;
    function Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
    function Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGetvendorlistcf_responseType }

  TXMLGetvendorlistcf_responseType = class(TXMLNode, IXMLGetvendorlistcf_responseType)
  protected
    { IXMLGetvendorlistcf_responseType }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Vendors: IXMLVendorsType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVendorsType }

  TXMLVendorsType = class(TXMLNodeCollection, IXMLVendorsType)
  protected
    { IXMLVendorsType }
    function Get_Vendor(Index: Integer): IXMLVendorType;
    function Add: IXMLVendorType;
    function Insert(const Index: Integer): IXMLVendorType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVendorType }

  TXMLVendorType = class(TXMLNode, IXMLVendorType)
  protected
    { IXMLVendorType }
    function Get_Vendor_name: WideString;
    procedure Set_Vendor_name(Value: WideString);
  end;

{ TXMLGetstatuslistcf_responseType }

  TXMLGetstatuslistcf_responseType = class(TXMLNode, IXMLGetstatuslistcf_responseType)
  protected
    { IXMLGetstatuslistcf_responseType }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Statuses: IXMLStatusesType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStatusesType }

  TXMLStatusesType = class(TXMLNodeCollection, IXMLStatusesType)
  protected
    { IXMLStatusesType }
    function Get_Status(Index: Integer): IXMLStatusType;
    function Add: IXMLStatusType;
    function Insert(const Index: Integer): IXMLStatusType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStatusType }

  TXMLStatusType = class(TXMLNode, IXMLStatusType)
  protected
    { IXMLStatusType }
    function Get_Status_id: Integer;
    function Get_Status_name: WideString;
    procedure Set_Status_id(Value: Integer);
    procedure Set_Status_name(Value: WideString);
  end;

{ TXMLGetorderlistcf_responseType }

  TXMLGetorderlistcf_responseType = class(TXMLNode, IXMLGetorderlistcf_responseType)
  protected
    { IXMLGetorderlistcf_responseType }
    function Get_Status: Integer;
    function Get_Count: Integer;
    function Get_Orders: IXMLOrdersType;
    procedure Set_Status(Value: Integer);
    procedure Set_Count(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrdersType }

  TXMLOrdersType = class(TXMLNodeCollection, IXMLOrdersType)
  protected
    { IXMLOrdersType }
    function Get_Order(Index: Integer): IXMLOrderType;
    function Add: IXMLOrderType;
    function Insert(const Index: Integer): IXMLOrderType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrderType }

  TXMLOrderType = class(TXMLNode, IXMLOrderType)
  protected
    { IXMLOrderType }
    function Get_Appraisal_order_id: Integer;
    function Get_Appraisal_type_name: WideString;
    function Get_Appraisal_status_name: WideString;
    function Get_Appraisal_received_date: WideString;
    function Get_Appraisal_accept_date: WideString;
    function Get_Appraisal_due_date: WideString;
    function Get_Requestor_company_name: WideString;
    function Get_Requestor_firstname: WideString;
    function Get_Requestor_lastname: WideString;
    function Get_Requestor_address: WideString;
    function Get_Appraisal_amount_invoiced: Integer;
    function Get_Appraisal_amount_paid: Integer;
    function Get_Appraisal_order_reference: WideString;
    function Get_Vendor_name: WideString;
    function Get_Appraisal_type: WideString;
    function Get_Appraisal_purpose: WideString;
    function Get_Appraisal_payment_method: WideString;
    function Get_Appraisal_delivery_method: WideString;
    function Get_Appraisal_order_owner: WideString;
    function Get_Appraisal_fha_number: WideString;
    function Get_Appraisal_comment: WideString;
    function Get_Appraisal_other_purpose: WideString;
    function Get_Appraisal_other_type: WideString;
    function Get_Appraisal_requested_due_date: WideString;
    function Get_Requestor_address2: WideString;
    function Get_Requestor_city: WideString;
    function Get_Requestor_state: WideString;
    function Get_Requestor_zip: WideString;
    function Get_Requestor_phone: WideString;
    function Get_Requestor_extension: WideString;
    function Get_Requestor_fax: WideString;
    function Get_Requestor_email: WideString;
    function Get_Lender_name: WideString;
    function Get_Lender_loan_number: WideString;
    function Get_Lender_value_estimate: WideString;
    function Get_Lender_loan_amount: WideString;
    function Get_Lender_borrower_lastname: WideString;
    function Get_Lender_borrower_firstname: WideString;
    function Get_Lender_loan_to_value: Integer;
    function Get_Property_type: WideString;
    function Get_Property_address: WideString;
    function Get_Property_city: WideString;
    function Get_Property_state: WideString;
    function Get_Property__total_rooms: Integer;
    function Get_Property_bedrooms: Integer;
    function Get_Property_baths: WideString;
    function Get_Property_zipcode: WideString;
    function Get_Property_comment: WideString;
    function Get_Occupancy_other_comment: WideString;
    function Get_Vendor_raw_data: WideString;
    function Get_Sub_status_id: Integer;
    function Get_Scheduled_date: WideString;
    function Get_Inspection_completed_date: WideString;
    function Get_Delayed_datetime: WideString;
    procedure Set_Appraisal_order_id(Value: Integer);
    procedure Set_Appraisal_type_name(Value: WideString);
    procedure Set_Appraisal_status_name(Value: WideString);
    procedure Set_Appraisal_received_date(Value: WideString);
    procedure Set_Appraisal_accept_date(Value: WideString);
    procedure Set_Appraisal_due_date(Value: WideString);
    procedure Set_Requestor_company_name(Value: WideString);
    procedure Set_Requestor_firstname(Value: WideString);
    procedure Set_Requestor_lastname(Value: WideString);
    procedure Set_Requestor_address(Value: WideString);
    procedure Set_Appraisal_amount_invoiced(Value: Integer);
    procedure Set_Appraisal_amount_paid(Value: Integer);
    procedure Set_Appraisal_order_reference(Value: WideString);
    procedure Set_Vendor_name(Value: WideString);
    procedure Set_Appraisal_type(Value: WideString);
    procedure Set_Appraisal_purpose(Value: WideString);
    procedure Set_Appraisal_payment_method(Value: WideString);
    procedure Set_Appraisal_delivery_method(Value: WideString);
    procedure Set_Appraisal_order_owner(Value: WideString);
    procedure Set_Appraisal_fha_number(Value: WideString);
    procedure Set_Appraisal_comment(Value: WideString);
    procedure Set_Appraisal_other_purpose(Value: WideString);
    procedure Set_Appraisal_other_type(Value: WideString);
    procedure Set_Appraisal_requested_due_date(Value: WideString);
    procedure Set_Requestor_address2(Value: WideString);
    procedure Set_Requestor_city(Value: WideString);
    procedure Set_Requestor_state(Value: WideString);
    procedure Set_Requestor_zip(Value: WideString);
    procedure Set_Requestor_phone(Value: WideString);
    procedure Set_Requestor_extension(Value: WideString);
    procedure Set_Requestor_fax(Value: WideString);
    procedure Set_Requestor_email(Value: WideString);
    procedure Set_Lender_name(Value: WideString);
    procedure Set_Lender_loan_number(Value: WideString);
    procedure Set_Lender_value_estimate(Value: WideString);
    procedure Set_Lender_loan_amount(Value: WideString);
    procedure Set_Lender_borrower_lastname(Value: WideString);
    procedure Set_Lender_borrower_firstname(Value: WideString);
    procedure Set_Lender_loan_to_value(Value: Integer);
    procedure Set_Property_type(Value: WideString);
    procedure Set_Property_address(Value: WideString);
    procedure Set_Property_city(Value: WideString);
    procedure Set_Property_state(Value: WideString);
    procedure Set_Property__total_rooms(Value: Integer);
    procedure Set_Property_bedrooms(Value: Integer);
    procedure Set_Property_baths(Value: WideString);
    procedure Set_Property_zipcode(Value: WideString);
    procedure Set_Property_comment(Value: WideString);
    procedure Set_Occupancy_other_comment(Value: WideString);
    procedure Set_Vendor_raw_data(Value: WideString);
    procedure Set_Sub_status_id(Value: Integer);
    procedure Set_Scheduled_date(Value: WideString);
    procedure Set_Inspection_completed_date(Value: WideString);
    procedure Set_Delayed_datetime(Value: WideString);
  end;

{ TXMLGetorderdetailcf_responseType }

  TXMLGetorderdetailcf_responseType = class(TXMLNode, IXMLGetorderdetailcf_responseType)
  protected
    { IXMLGetorderdetailcf_responseType }
    function Get_Status: Integer;
    function Get_Access_token: WideString;
    function Get_Order: IXMLOrderType;
    procedure Set_Status(Value: Integer);
    procedure Set_Access_token(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGetStatusListCFType }

  TXMLGetStatusListCFType = class(TXMLNode, IXMLGetStatusListCFType)
  protected
    { IXMLGetStatusListCFType }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGetOrderListCFType }

  TXMLGetOrderListCFType = class(TXMLNode, IXMLGetOrderListCFType)
  protected
    { IXMLGetOrderListCFType }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGetOrderDetailCFType }

  TXMLGetOrderDetailCFType = class(TXMLNode, IXMLGetOrderDetailCFType)
  protected
    { IXMLGetOrderDetailCFType }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetOrderManagementServices(Doc: IXMLDocument): IXMLOrderManagementServicesType;
function LoadOrderManagementServices(const FileName: WideString): IXMLOrderManagementServicesType;
function NewOrderManagementServices: IXMLOrderManagementServicesType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetOrderManagementServices(Doc: IXMLDocument): IXMLOrderManagementServicesType;
begin
  Result := Doc.GetDocBinding('OrderManagementServices', TXMLOrderManagementServicesType, TargetNamespace) as IXMLOrderManagementServicesType;
end;

function LoadOrderManagementServices(const FileName: WideString): IXMLOrderManagementServicesType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('OrderManagementServices', TXMLOrderManagementServicesType, TargetNamespace) as IXMLOrderManagementServicesType;
end;

function NewOrderManagementServices: IXMLOrderManagementServicesType;
begin
  Result := NewXMLDocument.GetDocBinding('OrderManagementServices', TXMLOrderManagementServicesType, TargetNamespace) as IXMLOrderManagementServicesType;
end;

{ TXMLOrderManagementServicesType }

procedure TXMLOrderManagementServicesType.AfterConstruction;
begin
  RegisterChildNode('GetVendorListCF', TXMLGetVendorListCFType);
  RegisterChildNode('GetStatusListCF', TXMLGetStatusListCFType);
  RegisterChildNode('GetOrderListCF', TXMLGetOrderListCFType);
  RegisterChildNode('GetOrderDetailCF', TXMLGetOrderDetailCFType);
  inherited;
end;

function TXMLOrderManagementServicesType.Get_GetVendorListCF: IXMLGetVendorListCFType;
begin
  Result := ChildNodes['GetVendorListCF'] as IXMLGetVendorListCFType;
end;

function TXMLOrderManagementServicesType.Get_GetStatusListCF: IXMLGetStatusListCFType;
begin
  Result := ChildNodes['GetStatusListCF'] as IXMLGetStatusListCFType;
end;

function TXMLOrderManagementServicesType.Get_GetOrderListCF: IXMLGetOrderListCFType;
begin
  Result := ChildNodes['GetOrderListCF'] as IXMLGetOrderListCFType;
end;

function TXMLOrderManagementServicesType.Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
begin
  Result := ChildNodes['GetOrderDetailCF'] as IXMLGetOrderDetailCFType;
end;

{ TXMLGetVendorListCFType }

procedure TXMLGetVendorListCFType.AfterConstruction;
begin
  RegisterChildNode('Result', TXMLResultType);
  RegisterChildNode('ResponseData', TXMLResponseDataType);
  inherited;
end;

function TXMLGetVendorListCFType.Get_Result: IXMLResultType;
begin
  Result := ChildNodes['Result'] as IXMLResultType;
end;

function TXMLGetVendorListCFType.Get_ResponseData: IXMLResponseDataType;
begin
  Result := ChildNodes['ResponseData'] as IXMLResponseDataType;
end;

{ TXMLResultType }

function TXMLResultType.Get_Code: Integer;
begin
//   if VarIsNumeric(ChildNodes['Code'].NodeValue) then
     Result := ChildNodes['Code'].NodeValue;
end;

procedure TXMLResultType.Set_Code(Value: Integer);
begin
  ChildNodes['Code'].NodeValue := Value;
end;

function TXMLResultType.Get_Type_: WideString;
begin
  Result := varToStrDef(ChildNodes['Type'].Text, '');
end;

procedure TXMLResultType.Set_Type_(Value: WideString);
begin
  ChildNodes['Type'].NodeValue := Value;
end;

function TXMLResultType.Get_Description: WideString;
begin
  Result := varToStrDef(ChildNodes['Description'].Text, '');
end;

procedure TXMLResultType.Set_Description(Value: WideString);
begin
  ChildNodes['Description'].NodeValue := Value;
end;

{ TXMLResponseDataType }

procedure TXMLResponseDataType.AfterConstruction;
begin
  RegisterChildNode('getvendorlistcf_response', TXMLGetvendorlistcf_responseType);
  RegisterChildNode('getstatuslistcf_response', TXMLGetstatuslistcf_responseType);
  RegisterChildNode('getorderlistcf_response', TXMLGetorderlistcf_responseType);
  RegisterChildNode('getorderdetailcf_response', TXMLGetorderdetailcf_responseType);
  inherited;
end;

function TXMLResponseDataType.Get_Getvendorlistcf_response: IXMLGetvendorlistcf_responseType;
begin
  Result := ChildNodes['getvendorlistcf_response'] as IXMLGetvendorlistcf_responseType;
end;

function TXMLResponseDataType.Get_Getstatuslistcf_response: IXMLGetstatuslistcf_responseType;
begin
  Result := ChildNodes['getstatuslistcf_response'] as IXMLGetstatuslistcf_responseType;
end;

function TXMLResponseDataType.Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
begin
  Result := ChildNodes['getorderlistcf_response'] as IXMLGetorderlistcf_responseType;
end;

function TXMLResponseDataType.Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
begin
  Result := ChildNodes['getorderdetailcf_response'] as IXMLGetorderdetailcf_responseType;
end;

{ TXMLGetvendorlistcf_responseType }

procedure TXMLGetvendorlistcf_responseType.AfterConstruction;
begin
  RegisterChildNode('vendors', TXMLVendorsType);
  inherited;
end;

function TXMLGetvendorlistcf_responseType.Get_Status: Integer;
begin
  Result := AttributeNodes['status'].NodeValue;
end;

procedure TXMLGetvendorlistcf_responseType.Set_Status(Value: Integer);
begin
  SetAttribute('status', Value);
end;

function TXMLGetvendorlistcf_responseType.Get_Count: Integer;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLGetvendorlistcf_responseType.Set_Count(Value: Integer);
begin
  SetAttribute('count', Value);
end;

function TXMLGetvendorlistcf_responseType.Get_Vendors: IXMLVendorsType;
begin
  Result := ChildNodes['vendors'] as IXMLVendorsType;
end;

{ TXMLVendorsType }

procedure TXMLVendorsType.AfterConstruction;
begin
  RegisterChildNode('vendor', TXMLVendorType);
  ItemTag := 'vendor';
  ItemInterface := IXMLVendorType;
  inherited;
end;

function TXMLVendorsType.Get_Vendor(Index: Integer): IXMLVendorType;
begin
  Result := List[Index] as IXMLVendorType;
end;

function TXMLVendorsType.Add: IXMLVendorType;
begin
  Result := AddItem(-1) as IXMLVendorType;
end;

function TXMLVendorsType.Insert(const Index: Integer): IXMLVendorType;
begin
  Result := AddItem(Index) as IXMLVendorType;
end;

{ TXMLVendorType }

function TXMLVendorType.Get_Vendor_name: WideString;
begin
  Result := varToStrDef(ChildNodes['vendor_name'].Text, '');
end;

procedure TXMLVendorType.Set_Vendor_name(Value: WideString);
begin
  ChildNodes['vendor_name'].NodeValue := Value;
end;

{ TXMLGetstatuslistcf_responseType }

procedure TXMLGetstatuslistcf_responseType.AfterConstruction;
begin
  RegisterChildNode('statuses', TXMLStatusesType);
  inherited;
end;

function TXMLGetstatuslistcf_responseType.Get_Status: Integer;
begin
  Result := AttributeNodes['status'].NodeValue;
end;

procedure TXMLGetstatuslistcf_responseType.Set_Status(Value: Integer);
begin
  SetAttribute('status', Value);
end;

function TXMLGetstatuslistcf_responseType.Get_Count: Integer;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLGetstatuslistcf_responseType.Set_Count(Value: Integer);
begin
  SetAttribute('count', Value);
end;

function TXMLGetstatuslistcf_responseType.Get_Statuses: IXMLStatusesType;
begin
  Result := ChildNodes['statuses'] as IXMLStatusesType;
end;

{ TXMLStatusesType }

procedure TXMLStatusesType.AfterConstruction;
begin
  RegisterChildNode('status', TXMLStatusType);
  ItemTag := 'status';
  ItemInterface := IXMLStatusType;
  inherited;
end;

function TXMLStatusesType.Get_Status(Index: Integer): IXMLStatusType;
begin
  Result := List[Index] as IXMLStatusType;
end;

function TXMLStatusesType.Add: IXMLStatusType;
begin
  Result := AddItem(-1) as IXMLStatusType;
end;

function TXMLStatusesType.Insert(const Index: Integer): IXMLStatusType;
begin
  Result := AddItem(Index) as IXMLStatusType;
end;

{ TXMLStatusType }

function TXMLStatusType.Get_Status_id: Integer;
begin
  Result := ChildNodes['status_id'].NodeValue;
end;

procedure TXMLStatusType.Set_Status_id(Value: Integer);
begin
  ChildNodes['status_id'].NodeValue := Value;
end;

function TXMLStatusType.Get_Status_name: WideString;
begin
  Result := varToStrDef(ChildNodes['status_name'].Text, '');
end;

procedure TXMLStatusType.Set_Status_name(Value: WideString);
begin
  ChildNodes['status_name'].NodeValue := Value;
end;

{ TXMLGetorderlistcf_responseType }

procedure TXMLGetorderlistcf_responseType.AfterConstruction;
begin
  RegisterChildNode('orders', TXMLOrdersType);
  inherited;
end;

function TXMLGetorderlistcf_responseType.Get_Status: Integer;
begin
  Result := AttributeNodes['status'].NodeValue;
end;

procedure TXMLGetorderlistcf_responseType.Set_Status(Value: Integer);
begin
  SetAttribute('status', Value);
end;

function TXMLGetorderlistcf_responseType.Get_Count: Integer;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLGetorderlistcf_responseType.Set_Count(Value: Integer);
begin
  SetAttribute('count', Value);
end;

function TXMLGetorderlistcf_responseType.Get_Orders: IXMLOrdersType;
begin
  Result := ChildNodes['orders'] as IXMLOrdersType;
end;

{ TXMLOrdersType }

procedure TXMLOrdersType.AfterConstruction;
begin
  RegisterChildNode('order', TXMLOrderType);
  ItemTag := 'order';
  ItemInterface := IXMLOrderType;
  inherited;
end;

function TXMLOrdersType.Get_Order(Index: Integer): IXMLOrderType;
begin
  Result := List[Index] as IXMLOrderType;
end;

function TXMLOrdersType.Add: IXMLOrderType;
begin
  Result := AddItem(-1) as IXMLOrderType;
end;

function TXMLOrdersType.Insert(const Index: Integer): IXMLOrderType;
begin
  Result := AddItem(Index) as IXMLOrderType;
end;

{ TXMLOrderType }

function TXMLOrderType.Get_Appraisal_order_id: Integer;
begin
  if VarIsNull(ChildNodes['appraisal_order_id'].NodeValue) then
    result := 0
  else
     result := ChildNodes['appraisal_order_id'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_order_id(Value: Integer);
begin
  ChildNodes['appraisal_order_id'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_type_name: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_type_name'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_type_name(Value: WideString);
begin
  ChildNodes['appraisal_type_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_status_name: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_status_name'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_status_name(Value: WideString);
begin
  ChildNodes['appraisal_status_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_received_date: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_received_date'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_received_date(Value: WideString);
begin
  ChildNodes['appraisal_received_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_accept_date: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_accept_date'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_accept_date(Value: WideString);
begin
  ChildNodes['appraisal_accept_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_due_date: WideString;
begin
  Result :=varToStrDef(ChildNodes['appraisal_due_date'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_due_date(Value: WideString);
begin
  ChildNodes['appraisal_due_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_company_name: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_company_name'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_company_name(Value: WideString);
begin
  ChildNodes['requestor_company_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_firstname: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_firstname'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_firstname(Value: WideString);
begin
  ChildNodes['requestor_firstname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_lastname: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_lastname'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_lastname(Value: WideString);
begin
  ChildNodes['requestor_lastname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_address: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_address'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_address(Value: WideString);
begin
  ChildNodes['requestor_address'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_amount_invoiced: Integer;
begin
  if varIsNull(ChildNodes['appraisal_amount_invoiced'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['appraisal_amount_invoiced'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_amount_invoiced(Value: Integer);
begin
  ChildNodes['appraisal_amount_invoiced'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_amount_paid: Integer;
begin
  if VarIsNull(ChildNodes['appraisal_amount_paid'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['appraisal_amount_paid'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_amount_paid(Value: Integer);
begin
  ChildNodes['appraisal_amount_paid'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_order_reference: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_order_reference'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_order_reference(Value: WideString);
begin
  ChildNodes['appraisal_order_reference'].NodeValue := Value;
end;

function TXMLOrderType.Get_Vendor_name: WideString;
begin
  Result := varToStrDef(ChildNodes['vendor_name'].Text, '');
end;

procedure TXMLOrderType.Set_Vendor_name(Value: WideString);
begin
  ChildNodes['vendor_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_type: WideString;
begin
  Result :=varToStrDef( ChildNodes['appraisal_type'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_type(Value: WideString);
begin
  ChildNodes['appraisal_type'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_purpose: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_purpose'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_purpose(Value: WideString);
begin
  ChildNodes['appraisal_purpose'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_payment_method: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_payment_method'].Text,'');
end;

procedure TXMLOrderType.Set_Appraisal_payment_method(Value: WideString);
begin
  ChildNodes['appraisal_payment_method'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_delivery_method: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_delivery_method'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_delivery_method(Value: WideString);
begin
  ChildNodes['appraisal_delivery_method'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_order_owner: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_order_owner'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_order_owner(Value: WideString);
begin
  ChildNodes['appraisal_order_owner'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_fha_number: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_fha_number'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_fha_number(Value: WideString);
begin
  ChildNodes['appraisal_fha_number'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_comment: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_comment'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_comment(Value: WideString);
begin
  ChildNodes['appraisal_comment'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_other_purpose: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_other_purpose'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_other_purpose(Value: WideString);
begin
  ChildNodes['appraisal_other_purpose'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_other_type: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_other_type'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_other_type(Value: WideString);
begin
  ChildNodes['appraisal_other_type'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_requested_due_date: WideString;
begin
  Result := varToStrDef(ChildNodes['appraisal_requested_due_date'].Text, '');
end;

procedure TXMLOrderType.Set_Appraisal_requested_due_date(Value: WideString);
begin
  ChildNodes['appraisal_requested_due_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_address2: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_address2'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_address2(Value: WideString);
begin
  ChildNodes['requestor_address2'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_city: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_city'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_city(Value: WideString);
begin
  ChildNodes['requestor_city'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_state: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_state'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_state(Value: WideString);
begin
  ChildNodes['requestor_state'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_zip: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_zip'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_zip(Value: WideString);
begin
  ChildNodes['requestor_zip'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_phone: WideString;
begin
  Result := ChildNodes['requestor_phone'].Text;
end;

procedure TXMLOrderType.Set_Requestor_phone(Value: WideString);
begin
  ChildNodes['requestor_phone'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_extension: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_extension'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_extension(Value: WideString);
begin
  ChildNodes['requestor_extension'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_fax: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_fax'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_fax(Value: WideString);
begin
  ChildNodes['requestor_fax'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_email: WideString;
begin
  Result := varToStrDef(ChildNodes['requestor_email'].Text, '');
end;

procedure TXMLOrderType.Set_Requestor_email(Value: WideString);
begin
  ChildNodes['requestor_email'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_name: WideString;
begin
  Result := varToStrDef(ChildNodes['lender_name'].Text, '');
end;

procedure TXMLOrderType.Set_Lender_name(Value: WideString);
begin
  ChildNodes['lender_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_loan_number: WideString;
begin
  Result := varToStrDef(ChildNodes['lender_loan_number'].NodeValue, '');
end;

procedure TXMLOrderType.Set_Lender_loan_number(Value: WideString);
begin
  ChildNodes['lender_loan_number'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_value_estimate: WideString;
begin
  Result := ChildNodes['lender_value_estimate'].Text;
end;

procedure TXMLOrderType.Set_Lender_value_estimate(Value: WideString);
begin
  ChildNodes['lender_value_estimate'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_loan_amount: WideString;
begin
  Result := ChildNodes['lender_loan_amount'].Text;
end;

procedure TXMLOrderType.Set_Lender_loan_amount(Value: WideString);
begin
  ChildNodes['lender_loan_amount'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_borrower_lastname: WideString;
begin
  Result := ChildNodes['lender_borrower_lastname'].Text;
end;

procedure TXMLOrderType.Set_Lender_borrower_lastname(Value: WideString);
begin
  ChildNodes['lender_borrower_lastname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_borrower_firstname: WideString;
begin
  Result := ChildNodes['lender_borrower_firstname'].Text;
end;

procedure TXMLOrderType.Set_Lender_borrower_firstname(Value: WideString);
begin
  ChildNodes['lender_borrower_firstname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_loan_to_value: Integer;
begin
  if VarIsNull(ChildNodes['lender_loan_to_value'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['lender_loan_to_value'].NodeValue;
end;

procedure TXMLOrderType.Set_Lender_loan_to_value(Value: Integer);
begin
  ChildNodes['lender_loan_to_value'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_type: WideString;
begin
  Result := ChildNodes['property_type'].Text;
end;

procedure TXMLOrderType.Set_Property_type(Value: WideString);
begin
  ChildNodes['property_type'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_address: WideString;
begin
  Result := ChildNodes['property_address'].Text;
end;

procedure TXMLOrderType.Set_Property_address(Value: WideString);
begin
  ChildNodes['property_address'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_city: WideString;
begin
  Result := ChildNodes['property_city'].Text;
end;

procedure TXMLOrderType.Set_Property_city(Value: WideString);
begin
  ChildNodes['property_city'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_state: WideString;
begin
  Result := ChildNodes['property_state'].Text;
end;

procedure TXMLOrderType.Set_Property_state(Value: WideString);
begin
  ChildNodes['property_state'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property__total_rooms: Integer;
begin
  if VarIsNull(ChildNodes['property__total_rooms'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['property__total_rooms'].NodeValue;
end;

procedure TXMLOrderType.Set_Property__total_rooms(Value: Integer);
begin
  ChildNodes['property__total_rooms'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_bedrooms: Integer;
begin
  if VarIsNull(ChildNodes['property_bedrooms'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['property_bedrooms'].NodeValue;
end;

procedure TXMLOrderType.Set_Property_bedrooms(Value: Integer);
begin
  ChildNodes['property_bedrooms'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_baths: WideString;
begin
  Result := ChildNodes['property_baths'].Text;
end;

procedure TXMLOrderType.Set_Property_baths(Value: WideString);
begin
  ChildNodes['property_baths'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_zipcode: WideString;
begin
  Result := ChildNodes['property_zipcode'].Text;
end;

procedure TXMLOrderType.Set_Property_zipcode(Value: WideString);
begin
  ChildNodes['property_zipcode'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_comment: WideString;
begin
  Result := ChildNodes['property_comment'].Text;
end;

procedure TXMLOrderType.Set_Property_comment(Value: WideString);
begin
  ChildNodes['property_comment'].NodeValue := Value;
end;

function TXMLOrderType.Get_Occupancy_other_comment: WideString;
begin
  Result := ChildNodes['occupancy_other_comment'].Text;
end;

procedure TXMLOrderType.Set_Occupancy_other_comment(Value: WideString);
begin
  ChildNodes['occupancy_other_comment'].NodeValue := Value;
end;

function TXMLOrderType.Get_Vendor_raw_data: WideString;
begin
  Result := ChildNodes['vendor_raw_data'].Text;
end;

procedure TXMLOrderType.Set_Vendor_raw_data(Value: WideString);
begin
  ChildNodes['vendor_raw_data'].NodeValue := Value;
end;


function TXMLOrderType.Get_Sub_status_id: Integer;
begin
  if VarIsNull(ChildNodes['sub_status_id'].NodeValue) then
    result := 0
  else
    Result := ChildNodes['sub_status_id'].NodeValue;
end;

procedure TXMLOrderType.Set_Sub_status_id(Value: Integer);
begin
    ChildNodes['sub_status_id'].NodeValue := Value;
end;

function TXMLOrderType.Get_Scheduled_date: WideString;
begin
  Result := ChildNodes['scheduled_date'].Text;
end;

procedure TXMLOrderType.Set_Scheduled_date(Value: WideString);
begin
  ChildNodes['scheduled_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Inspection_completed_date: WideString;
begin
  Result := ChildNodes['inspection_completed_date'].Text;
end;

procedure TXMLOrderType.Set_Inspection_completed_date(Value: WideString);
begin
  ChildNodes['inspection_completed_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Delayed_datetime: WideString;
begin
  Result := ChildNodes['delayed_datetime'].Text;
end;

procedure TXMLOrderType.Set_Delayed_datetime(Value: WideString);
begin
  ChildNodes['delayed_datetime'].NodeValue := Value;
end;

{ TXMLGetorderdetailcf_responseType }

procedure TXMLGetorderdetailcf_responseType.AfterConstruction;
begin
  RegisterChildNode('order', TXMLOrderType);
  inherited;
end;

function TXMLGetorderdetailcf_responseType.Get_Status: Integer;
begin
  if VarIsNull(AttributeNodes['status'].NodeValue) then
    result := 0
  else
  Result := AttributeNodes['status'].NodeValue;
end;

procedure TXMLGetorderdetailcf_responseType.Set_Status(Value: Integer);
begin
  SetAttribute('status', Value);
end;

function TXMLGetorderdetailcf_responseType.Get_Access_token: WideString;
begin
  Result := ChildNodes['access_token'].Text;
end;

procedure TXMLGetorderdetailcf_responseType.Set_Access_token(Value: WideString);
begin
  ChildNodes['access_token'].NodeValue := Value;
end;


function TXMLGetorderdetailcf_responseType.Get_Order: IXMLOrderType;
begin
  Result := ChildNodes['order'] as IXMLOrderType;
end;

{ TXMLGetStatusListCFType }

procedure TXMLGetStatusListCFType.AfterConstruction;
begin
  RegisterChildNode('Result', TXMLResultType);
  RegisterChildNode('ResponseData', TXMLResponseDataType);
  inherited;
end;

function TXMLGetStatusListCFType.Get_Result: IXMLResultType;
begin
  Result := ChildNodes['Result'] as IXMLResultType;
end;

function TXMLGetStatusListCFType.Get_ResponseData: IXMLResponseDataType;
begin
  Result := ChildNodes['ResponseData'] as IXMLResponseDataType;
end;

{ TXMLGetOrderListCFType }

procedure TXMLGetOrderListCFType.AfterConstruction;
begin
  RegisterChildNode('Result', TXMLResultType);
  RegisterChildNode('ResponseData', TXMLResponseDataType);
  inherited;
end;

function TXMLGetOrderListCFType.Get_Result: IXMLResultType;
begin
  Result := ChildNodes['Result'] as IXMLResultType;
end;

function TXMLGetOrderListCFType.Get_ResponseData: IXMLResponseDataType;
begin
  Result := ChildNodes['ResponseData'] as IXMLResponseDataType;
end;

{ TXMLGetOrderDetailCFType }

procedure TXMLGetOrderDetailCFType.AfterConstruction;
begin
  RegisterChildNode('Result', TXMLResultType);
  RegisterChildNode('ResponseData', TXMLResponseDataType);
  inherited;
end;

function TXMLGetOrderDetailCFType.Get_Result: IXMLResultType;
begin
  Result := ChildNodes['Result'] as IXMLResultType;
end;

function TXMLGetOrderDetailCFType.Get_ResponseData: IXMLResponseDataType;
begin
  Result := ChildNodes['ResponseData'] as IXMLResponseDataType;
end;

end.