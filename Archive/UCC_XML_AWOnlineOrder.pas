
{***************************************************}
{                                                   }
{                 XML Data Binding                  }
{                                                   }
{         Generated on: 7/1/2015 2:47:18 PM         }
{       Generated from: C:\temp\AWOnlineOrder.xml   }
{   Settings stored in: C:\temp\AWOnlineOrder.xdb   }
{                                                   }
{***************************************************}

unit UCC_XML_AWOnlineOrder;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLOrderManagementServicesType = interface;
  IXMLGetOrderListCFType = interface;
  IXMLResultType = interface;
  IXMLResponseDataType = interface;
  IXMLGetorderlistcf_responseType = interface;
  IXMLOrdersType = interface;
  IXMLOrderType = interface;
  IXMLGetorderdetailcf_responseType = interface;
  IXMLGetOrderDetailCFType = interface;

{ IXMLOrderManagementServicesType }

  IXMLOrderManagementServicesType = interface(IXMLNode)
    ['{82E309D9-81AE-4222-957C-9F64C2840579}']
    { Property Accessors }
    function Get_GetOrderListCF: IXMLGetOrderListCFType;
    function Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
    { Methods & Properties }
    property GetOrderListCF: IXMLGetOrderListCFType read Get_GetOrderListCF;
    property GetOrderDetailCF: IXMLGetOrderDetailCFType read Get_GetOrderDetailCF;
  end;

{ IXMLGetOrderListCFType }

  IXMLGetOrderListCFType = interface(IXMLNode)
    ['{3AD322B5-CBBE-4E33-9045-EC8CEBAD0BE7}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ IXMLResultType }

  IXMLResultType = interface(IXMLNode)
    ['{D3B899B3-741B-454C-97D3-74B9AF7C1015}']
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
    ['{3D235DAC-1C57-427B-B981-4A8D29DBDF73}']
    { Property Accessors }
    function Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
    function Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
    { Methods & Properties }
    property Getorderlistcf_response: IXMLGetorderlistcf_responseType read Get_Getorderlistcf_response;
    property Getorderdetailcf_response: IXMLGetorderdetailcf_responseType read Get_Getorderdetailcf_response;
  end;

{ IXMLGetorderlistcf_responseType }

  IXMLGetorderlistcf_responseType = interface(IXMLNode)
    ['{5D40022B-8139-4A11-A84C-73CDA83736CC}']
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
    ['{024594AB-57ED-4A2F-87D9-B2F23CD46AAA}']
    { Property Accessors }
    function Get_Order(Index: Integer): IXMLOrderType;
    { Methods & Properties }
    function Add: IXMLOrderType;
    function Insert(const Index: Integer): IXMLOrderType;
    property Order[Index: Integer]: IXMLOrderType read Get_Order; default;
  end;

{ IXMLOrderType }

  IXMLOrderType = interface(IXMLNode)
    ['{2CBB2F1F-EF93-4A7B-8A0A-D58737A410E0}']
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
    function Get_Lender_loan_to_value: WideString;
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
    procedure Set_Lender_loan_to_value(Value: WideString);
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
    property Lender_loan_to_value: WideString read Get_Lender_loan_to_value write Set_Lender_loan_to_value;
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
  end;

{ IXMLGetorderdetailcf_responseType }

  IXMLGetorderdetailcf_responseType = interface(IXMLNode)
    ['{1BBA1560-F36F-48D6-8435-75605A4B3D5D}']
    { Property Accessors }
    function Get_Status: Integer;
    function Get_Order: IXMLOrderType;
    procedure Set_Status(Value: Integer);
    { Methods & Properties }
    property Status: Integer read Get_Status write Set_Status;
    property Order: IXMLOrderType read Get_Order;
  end;

{ IXMLGetOrderDetailCFType }

  IXMLGetOrderDetailCFType = interface(IXMLNode)
    ['{821EB193-EF5A-4A43-8E14-704139099382}']
    { Property Accessors }
    function Get_Result: IXMLResultType;
    function Get_ResponseData: IXMLResponseDataType;
    { Methods & Properties }
    property Result: IXMLResultType read Get_Result;
    property ResponseData: IXMLResponseDataType read Get_ResponseData;
  end;

{ Forward Decls }

  TXMLOrderManagementServicesType = class;
  TXMLGetOrderListCFType = class;
  TXMLResultType = class;
  TXMLResponseDataType = class;
  TXMLGetorderlistcf_responseType = class;
  TXMLOrdersType = class;
  TXMLOrderType = class;
  TXMLGetorderdetailcf_responseType = class;
  TXMLGetOrderDetailCFType = class;

{ TXMLOrderManagementServicesType }

  TXMLOrderManagementServicesType = class(TXMLNode, IXMLOrderManagementServicesType)
  protected
    { IXMLOrderManagementServicesType }
    function Get_GetOrderListCF: IXMLGetOrderListCFType;
    function Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
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
    function Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
    function Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
  public
    procedure AfterConstruction; override;
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
    function Get_Lender_loan_to_value: WideString;
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
    procedure Set_Lender_loan_to_value(Value: WideString);
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
  end;

{ TXMLGetorderdetailcf_responseType }

  TXMLGetorderdetailcf_responseType = class(TXMLNode, IXMLGetorderdetailcf_responseType)
  protected
    { IXMLGetorderdetailcf_responseType }
    function Get_Status: Integer;
    function Get_Order: IXMLOrderType;
    procedure Set_Status(Value: Integer);
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
  RegisterChildNode('GetOrderListCF', TXMLGetOrderListCFType);
  RegisterChildNode('GetOrderDetailCF', TXMLGetOrderDetailCFType);
  inherited;
end;

function TXMLOrderManagementServicesType.Get_GetOrderListCF: IXMLGetOrderListCFType;
begin
  Result := ChildNodes['GetOrderListCF'] as IXMLGetOrderListCFType;
end;

function TXMLOrderManagementServicesType.Get_GetOrderDetailCF: IXMLGetOrderDetailCFType;
begin
  Result := ChildNodes['GetOrderDetailCF'] as IXMLGetOrderDetailCFType;
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

{ TXMLResultType }

function TXMLResultType.Get_Code: Integer;
begin
  Result := ChildNodes['Code'].NodeValue;
end;

procedure TXMLResultType.Set_Code(Value: Integer);
begin
  ChildNodes['Code'].NodeValue := Value;
end;

function TXMLResultType.Get_Type_: WideString;
begin
  Result := ChildNodes['Type'].Text;
end;

procedure TXMLResultType.Set_Type_(Value: WideString);
begin
  ChildNodes['Type'].NodeValue := Value;
end;

function TXMLResultType.Get_Description: WideString;
begin
  Result := ChildNodes['Description'].Text;
end;

procedure TXMLResultType.Set_Description(Value: WideString);
begin
  ChildNodes['Description'].NodeValue := Value;
end;

{ TXMLResponseDataType }

procedure TXMLResponseDataType.AfterConstruction;
begin
  RegisterChildNode('getorderlistcf_response', TXMLGetorderlistcf_responseType);
  RegisterChildNode('getorderdetailcf_response', TXMLGetorderdetailcf_responseType);
  inherited;
end;

function TXMLResponseDataType.Get_Getorderlistcf_response: IXMLGetorderlistcf_responseType;
begin
  Result := ChildNodes['getorderlistcf_response'] as IXMLGetorderlistcf_responseType;
end;

function TXMLResponseDataType.Get_Getorderdetailcf_response: IXMLGetorderdetailcf_responseType;
begin
  Result := ChildNodes['getorderdetailcf_response'] as IXMLGetorderdetailcf_responseType;
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
  Result := ChildNodes['appraisal_order_id'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_order_id(Value: Integer);
begin
  ChildNodes['appraisal_order_id'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_type_name: WideString;
begin
  Result := ChildNodes['appraisal_type_name'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_type_name(Value: WideString);
begin
  ChildNodes['appraisal_type_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_status_name: WideString;
begin
  Result := ChildNodes['appraisal_status_name'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_status_name(Value: WideString);
begin
  ChildNodes['appraisal_status_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_received_date: WideString;
begin
  Result := ChildNodes['appraisal_received_date'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_received_date(Value: WideString);
begin
  ChildNodes['appraisal_received_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_accept_date: WideString;
begin
  Result := ChildNodes['appraisal_accept_date'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_accept_date(Value: WideString);
begin
  ChildNodes['appraisal_accept_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_due_date: WideString;
begin
  Result := ChildNodes['appraisal_due_date'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_due_date(Value: WideString);
begin
  ChildNodes['appraisal_due_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_company_name: WideString;
begin
  Result := ChildNodes['requestor_company_name'].Text;
end;

procedure TXMLOrderType.Set_Requestor_company_name(Value: WideString);
begin
  ChildNodes['requestor_company_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_firstname: WideString;
begin
  Result := ChildNodes['requestor_firstname'].Text;
end;

procedure TXMLOrderType.Set_Requestor_firstname(Value: WideString);
begin
  ChildNodes['requestor_firstname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_lastname: WideString;
begin
  Result := ChildNodes['requestor_lastname'].Text;
end;

procedure TXMLOrderType.Set_Requestor_lastname(Value: WideString);
begin
  ChildNodes['requestor_lastname'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_address: WideString;
begin
  Result := ChildNodes['requestor_address'].Text;
end;

procedure TXMLOrderType.Set_Requestor_address(Value: WideString);
begin
  ChildNodes['requestor_address'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_amount_invoiced: Integer;
begin
  Result := ChildNodes['appraisal_amount_invoiced'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_amount_invoiced(Value: Integer);
begin
  ChildNodes['appraisal_amount_invoiced'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_amount_paid: Integer;
begin
  Result := ChildNodes['appraisal_amount_paid'].NodeValue;
end;

procedure TXMLOrderType.Set_Appraisal_amount_paid(Value: Integer);
begin
  ChildNodes['appraisal_amount_paid'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_order_reference: WideString;
begin
  Result := ChildNodes['appraisal_order_reference'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_order_reference(Value: WideString);
begin
  ChildNodes['appraisal_order_reference'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_type: WideString;
begin
  Result := ChildNodes['appraisal_type'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_type(Value: WideString);
begin
  ChildNodes['appraisal_type'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_purpose: WideString;
begin
  Result := ChildNodes['appraisal_purpose'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_purpose(Value: WideString);
begin
  ChildNodes['appraisal_purpose'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_payment_method: WideString;
begin
  Result := ChildNodes['appraisal_payment_method'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_payment_method(Value: WideString);
begin
  ChildNodes['appraisal_payment_method'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_delivery_method: WideString;
begin
  Result := ChildNodes['appraisal_delivery_method'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_delivery_method(Value: WideString);
begin
  ChildNodes['appraisal_delivery_method'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_order_owner: WideString;
begin
  Result := ChildNodes['appraisal_order_owner'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_order_owner(Value: WideString);
begin
  ChildNodes['appraisal_order_owner'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_fha_number: WideString;
begin
  Result := ChildNodes['appraisal_fha_number'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_fha_number(Value: WideString);
begin
  ChildNodes['appraisal_fha_number'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_comment: WideString;
begin
  Result := ChildNodes['appraisal_comment'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_comment(Value: WideString);
begin
  ChildNodes['appraisal_comment'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_other_purpose: WideString;
begin
  Result := ChildNodes['appraisal_other_purpose'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_other_purpose(Value: WideString);
begin
  ChildNodes['appraisal_other_purpose'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_other_type: WideString;
begin
  Result := ChildNodes['appraisal_other_type'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_other_type(Value: WideString);
begin
  ChildNodes['appraisal_other_type'].NodeValue := Value;
end;

function TXMLOrderType.Get_Appraisal_requested_due_date: WideString;
begin
  Result := ChildNodes['appraisal_requested_due_date'].Text;
end;

procedure TXMLOrderType.Set_Appraisal_requested_due_date(Value: WideString);
begin
  ChildNodes['appraisal_requested_due_date'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_address2: WideString;
begin
  Result := ChildNodes['requestor_address2'].Text;
end;

procedure TXMLOrderType.Set_Requestor_address2(Value: WideString);
begin
  ChildNodes['requestor_address2'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_city: WideString;
begin
  Result := ChildNodes['requestor_city'].Text;
end;

procedure TXMLOrderType.Set_Requestor_city(Value: WideString);
begin
  ChildNodes['requestor_city'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_state: WideString;
begin
  Result := ChildNodes['requestor_state'].Text;
end;

procedure TXMLOrderType.Set_Requestor_state(Value: WideString);
begin
  ChildNodes['requestor_state'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_zip:WideString;
begin
  Result := ChildNodes['requestor_zip'].Text;
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
  Result := ChildNodes['requestor_extension'].Text;
end;

procedure TXMLOrderType.Set_Requestor_extension(Value: WideString);
begin
  ChildNodes['requestor_extension'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_fax: WideString;
begin
  Result := ChildNodes['requestor_fax'].Text;
end;

procedure TXMLOrderType.Set_Requestor_fax(Value: WideString);
begin
  ChildNodes['requestor_fax'].NodeValue := Value;
end;

function TXMLOrderType.Get_Requestor_email: WideString;
begin
  Result := ChildNodes['requestor_email'].Text;
end;

procedure TXMLOrderType.Set_Requestor_email(Value: WideString);
begin
  ChildNodes['requestor_email'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_name: WideString;
begin
  Result := ChildNodes['lender_name'].Text;
end;

procedure TXMLOrderType.Set_Lender_name(Value: WideString);
begin
  ChildNodes['lender_name'].NodeValue := Value;
end;

function TXMLOrderType.Get_Lender_loan_number: WideString;
begin
  Result := ChildNodes['lender_loan_number'].Text;
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

function TXMLOrderType.Get_Lender_loan_to_value: WideString;
begin
  Result := ChildNodes['lender_loan_to_value'].Text;
end;

procedure TXMLOrderType.Set_Lender_loan_to_value(Value: WideString);
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
  Result := ChildNodes['property__total_rooms'].NodeValue;
end;

procedure TXMLOrderType.Set_Property__total_rooms(Value: Integer);
begin
  ChildNodes['property__total_rooms'].NodeValue := Value;
end;

function TXMLOrderType.Get_Property_bedrooms: Integer;
begin
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

{ TXMLGetorderdetailcf_responseType }

procedure TXMLGetorderdetailcf_responseType.AfterConstruction;
begin
  RegisterChildNode('order', TXMLOrderType);
  inherited;
end;

function TXMLGetorderdetailcf_responseType.Get_Status: Integer;
begin
  Result := AttributeNodes['status'].NodeValue;
end;

procedure TXMLGetorderdetailcf_responseType.Set_Status(Value: Integer);
begin
  SetAttribute('status', Value);
end;

function TXMLGetorderdetailcf_responseType.Get_Order: IXMLOrderType;
begin
  Result := ChildNodes['order'] as IXMLOrderType;
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