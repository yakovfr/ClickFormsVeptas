
{*********************************************************************************}
{                                                                                 }
{                                XML Data Binding                                 }
{                                                                                 }
{         Generated on: 12/20/2012 8:08:39 AM                                     }
{       Generated from: C:\Users\jwyatt\Documents\ISGN\getOrderDataResponse.xml   }
{   Settings stored in: C:\Users\jwyatt\Documents\ISGN\getOrderDataResponse.xdb   }
{                                                                                 }
{*********************************************************************************}

unit ISGN_GetOrderDataResponse;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLGatorsAPIType = interface;
  IXMLOrder_DataType = interface;
  IXMLAppraisalType = interface;
  IXMLPropertyAddressType = interface;
  IXMLContactsType = interface;
  IXMLContactType = interface;
  IXMLDatesType = interface;
  IXMLOrderNotesType = interface;
  IXMLOrderNoteType = interface;
  IXMLMiscItemsType = interface;
  IXMLMiscItemType = interface;
  IXMLREPORTType = interface;

{ IXMLGatorsAPIType }

  IXMLGatorsAPIType = interface(IXMLNode)
    ['{00A3E8E6-0182-4690-BCAA-89A7C9C970B4}']
    { Property Accessors }
    function Get_Order_Data: IXMLOrder_DataType;
    { Methods & Properties }
    property Order_Data: IXMLOrder_DataType read Get_Order_Data;
  end;

{ IXMLOrder_DataType }

  IXMLOrder_DataType = interface(IXMLNode)
    ['{A662E839-5FAD-4E82-A473-EABF09FB8C45}']
    { Property Accessors }
    function Get_Customer_Order_Id: WideString;
    function Get_Order_Type: WideString;
    function Get_Appraisal: IXMLAppraisalType;
    function Get_REPORT: IXMLREPORTType;
    procedure Set_Customer_Order_Id(Value: WideString);
    procedure Set_Order_Type(Value: WideString);
    { Methods & Properties }
    property Customer_Order_Id: WideString read Get_Customer_Order_Id write Set_Customer_Order_Id;
    property Order_Type: WideString read Get_Order_Type write Set_Order_Type;
    property Appraisal: IXMLAppraisalType read Get_Appraisal;
    property REPORT: IXMLREPORTType read Get_REPORT;
  end;

{ IXMLAppraisalType }

  IXMLAppraisalType = interface(IXMLNode)
    ['{755CB596-D22D-40CA-9012-C9E6FBEDF708}']
    { Property Accessors }
    function Get_LoanNo: WideString;
    function Get_Loan_Desc: WideString;
    function Get_ActualCost: WideString;
    function Get_Appraisal_Code: Integer;
    function Get_ENV_Req: WideString;
    function Get_PropertyAddress: IXMLPropertyAddressType;
    function Get_PropertyId: WideString;
    function Get_Estimated_Value: Integer;
    function Get_Contacts: IXMLContactsType;
    function Get_StructureType: WideString;
    function Get_MarketValue: WideString;
    function Get_Dates: IXMLDatesType;
    function Get_AppraisalInfo: WideString;
    function Get_OrderNotes: IXMLOrderNotesType;
    procedure Set_LoanNo(Value: WideString);
    procedure Set_Loan_Desc(Value: WideString);
    procedure Set_ActualCost(Value: WideString);
    procedure Set_Appraisal_Code(Value: Integer);
    procedure Set_ENV_Req(Value: WideString);
    procedure Set_PropertyId(Value: WideString);
    procedure Set_Estimated_Value(Value: Integer);
    procedure Set_StructureType(Value: WideString);
    procedure Set_MarketValue(Value: WideString);
    procedure Set_AppraisalInfo(Value: WideString);
    { Methods & Properties }
    property LoanNo: WideString read Get_LoanNo write Set_LoanNo;
    property Loan_Desc: WideString read Get_Loan_Desc write Set_Loan_Desc;
    property ActualCost: WideString read Get_ActualCost write Set_ActualCost;
    property Appraisal_Code: Integer read Get_Appraisal_Code write Set_Appraisal_Code;
    property ENV_Req: WideString read Get_ENV_Req write Set_ENV_Req;
    property PropertyAddress: IXMLPropertyAddressType read Get_PropertyAddress;
    property PropertyId: WideString read Get_PropertyId write Set_PropertyId;
    property Estimated_Value: Integer read Get_Estimated_Value write Set_Estimated_Value;
    property Contacts: IXMLContactsType read Get_Contacts;
    property StructureType: WideString read Get_StructureType write Set_StructureType;
    property MarketValue: WideString read Get_MarketValue write Set_MarketValue;
    property Dates: IXMLDatesType read Get_Dates;
    property AppraisalInfo: WideString read Get_AppraisalInfo write Set_AppraisalInfo;
    property OrderNotes: IXMLOrderNotesType read Get_OrderNotes;
  end;

{ IXMLPropertyAddressType }

  IXMLPropertyAddressType = interface(IXMLNode)
    ['{BE6644B3-AFBC-49E0-BE97-8B314F9C84F6}']
    { Property Accessors }
    function Get_StreetAddress: WideString;
    function Get_City: WideString;
    function Get_State: WideString;
    function Get_ZipCode: WideString;
    function Get_County: WideString;
    procedure Set_StreetAddress(Value: WideString);
    procedure Set_City(Value: WideString);
    procedure Set_State(Value: WideString);
    procedure Set_ZipCode(Value: WideString);
    procedure Set_County(Value: WideString);
    { Methods & Properties }
    property StreetAddress: WideString read Get_StreetAddress write Set_StreetAddress;
    property City: WideString read Get_City write Set_City;
    property State: WideString read Get_State write Set_State;
    property ZipCode: WideString read Get_ZipCode write Set_ZipCode;
    property County: WideString read Get_County write Set_County;
  end;

{ IXMLContactsType }

  IXMLContactsType = interface(IXMLNodeCollection)
    ['{7773090F-332A-41EE-8621-C554D3B0C2B4}']
    { Property Accessors }
    function Get_Contact(Index: Integer): IXMLContactType;
    { Methods & Properties }
    function Add: IXMLContactType;
    function Insert(const Index: Integer): IXMLContactType;
    property Contact[Index: Integer]: IXMLContactType read Get_Contact; default;
  end;

{ IXMLContactType }

  IXMLContactType = interface(IXMLNode)
    ['{BD2214B1-7696-4C2E-88B6-B0AC68E973A7}']
    { Property Accessors }
    function Get_Type_: WideString;
    function Get_ID: WideString;
    function Get_Name: WideString;
    function Get_PhoneNo: WideString;
    function Get_StreetAddress: WideString;
    function Get_City: WideString;
    function Get_State: WideString;
    function Get_ZipCode: WideString;
    function Get_Email_Report_To: WideString;
    function Get_FaxNo: WideString;
    function Get_Contact: WideString;
    function Get_LastName: WideString;
    function Get_MaritalStatus: WideString;
    procedure Set_Type_(Value: WideString);
    procedure Set_ID(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_PhoneNo(Value: WideString);
    procedure Set_StreetAddress(Value: WideString);
    procedure Set_City(Value: WideString);
    procedure Set_State(Value: WideString);
    procedure Set_ZipCode(Value: WideString);
    procedure Set_Email_Report_To(Value: WideString);
    procedure Set_FaxNo(Value: WideString);
    procedure Set_Contact(Value: WideString);
    procedure Set_LastName(Value: WideString);
    procedure Set_MaritalStatus(Value: WideString);
    { Methods & Properties }
    property Type_: WideString read Get_Type_ write Set_Type_;
    property ID: WideString read Get_ID write Set_ID;
    property Name: WideString read Get_Name write Set_Name;
    property PhoneNo: WideString read Get_PhoneNo write Set_PhoneNo;
    property StreetAddress: WideString read Get_StreetAddress write Set_StreetAddress;
    property City: WideString read Get_City write Set_City;
    property State: WideString read Get_State write Set_State;
    property ZipCode: WideString read Get_ZipCode write Set_ZipCode;
    property Email_Report_To: WideString read Get_Email_Report_To write Set_Email_Report_To;
    property FaxNo: WideString read Get_FaxNo write Set_FaxNo;
    property Contact: WideString read Get_Contact write Set_Contact;
    property LastName: WideString read Get_LastName write Set_LastName;
    property MaritalStatus: WideString read Get_MaritalStatus write Set_MaritalStatus;
  end;

{ IXMLDatesType }

  IXMLDatesType = interface(IXMLNode)
    ['{096551F5-A9B8-4AD7-B256-6DAF0F446FCB}']
    { Property Accessors }
    function Get_OrderedDate: WideString;
    function Get_ProjAppointmentDate: WideString;
    function Get_ActlAppointmentDate: WideString;
    function Get_ProjHardcopyDate: WideString;
    function Get_ActlHardcopyDate: WideString;
    procedure Set_OrderedDate(Value: WideString);
    procedure Set_ProjAppointmentDate(Value: WideString);
    procedure Set_ActlAppointmentDate(Value: WideString);
    procedure Set_ProjHardcopyDate(Value: WideString);
    procedure Set_ActlHardcopyDate(Value: WideString);
    { Methods & Properties }
    property OrderedDate: WideString read Get_OrderedDate write Set_OrderedDate;
    property ProjAppointmentDate: WideString read Get_ProjAppointmentDate write Set_ProjAppointmentDate;
    property ActlAppointmentDate: WideString read Get_ActlAppointmentDate write Set_ActlAppointmentDate;
    property ProjHardcopyDate: WideString read Get_ProjHardcopyDate write Set_ProjHardcopyDate;
    property ActlHardcopyDate: WideString read Get_ActlHardcopyDate write Set_ActlHardcopyDate;
  end;

{ IXMLOrderNotesType }

  IXMLOrderNotesType = interface(IXMLNodeCollection)
    ['{3E566BB4-B534-4985-B396-79A55E9482AC}']
    { Property Accessors }
    function Get_OrderNote(Index: Integer): IXMLOrderNoteType;
    { Methods & Properties }
    function Add: IXMLOrderNoteType;
    function Insert(const Index: Integer): IXMLOrderNoteType;
    property OrderNote[Index: Integer]: IXMLOrderNoteType read Get_OrderNote; default;
  end;

{ IXMLOrderNoteType }

  IXMLOrderNoteType = interface(IXMLNode)
    ['{E023B16E-8102-4CC6-A107-5885ACD193C7}']
    { Property Accessors }
    function Get_NoteDate: WideString;
    function Get_UserId: WideString;
    function Get_NoteTypeCode: Integer;
    function Get_NoteTypeText: WideString;
    function Get_Notes: WideString;
    function Get_MiscItems: IXMLMiscItemsType;
    procedure Set_NoteDate(Value: WideString);
    procedure Set_UserId(Value: WideString);
    procedure Set_NoteTypeCode(Value: Integer);
    procedure Set_NoteTypeText(Value: WideString);
    procedure Set_Notes(Value: WideString);
    { Methods & Properties }
    property NoteDate: WideString read Get_NoteDate write Set_NoteDate;
    property UserId: WideString read Get_UserId write Set_UserId;
    property NoteTypeCode: Integer read Get_NoteTypeCode write Set_NoteTypeCode;
    property NoteTypeText: WideString read Get_NoteTypeText write Set_NoteTypeText;
    property Notes: WideString read Get_Notes write Set_Notes;
    property MiscItems: IXMLMiscItemsType read Get_MiscItems;
  end;

{ IXMLMiscItemsType }

  IXMLMiscItemsType = interface(IXMLNodeCollection)
    ['{080A7692-7B64-4D6B-8CB2-8AB0DAB88E45}']
    { Property Accessors }
    function Get_MiscItem(Index: Integer): IXMLMiscItemType;
    { Methods & Properties }
    function Add: IXMLMiscItemType;
    function Insert(const Index: Integer): IXMLMiscItemType;
    property MiscItem[Index: Integer]: IXMLMiscItemType read Get_MiscItem; default;
  end;

{ IXMLMiscItemType }

  IXMLMiscItemType = interface(IXMLNode)
    ['{8FE313FA-065C-4E77-A706-44642037EA2C}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLREPORTType }

  IXMLREPORTType = interface(IXMLNode)
    ['{31CAD787-E671-4811-B418-50BB018BA164}']
    { Property Accessors }
    function Get_DESCRIPTION: WideString;
    function Get_FILENUM: WideString;
    function Get_MAJORFORM: Integer;
    function Get_VERSION: WideString;
    procedure Set_DESCRIPTION(Value: WideString);
    procedure Set_FILENUM(Value: WideString);
    procedure Set_MAJORFORM(Value: Integer);
    procedure Set_VERSION(Value: WideString);
    { Methods & Properties }
    property DESCRIPTION: WideString read Get_DESCRIPTION write Set_DESCRIPTION;
    property FILENUM: WideString read Get_FILENUM write Set_FILENUM;
    property MAJORFORM: Integer read Get_MAJORFORM write Set_MAJORFORM;
    property VERSION: WideString read Get_VERSION write Set_VERSION;
  end;

{ Forward Decls }

  TXMLGatorsAPIType = class;
  TXMLOrder_DataType = class;
  TXMLAppraisalType = class;
  TXMLPropertyAddressType = class;
  TXMLContactsType = class;
  TXMLContactType = class;
  TXMLDatesType = class;
  TXMLOrderNotesType = class;
  TXMLOrderNoteType = class;
  TXMLMiscItemsType = class;
  TXMLMiscItemType = class;
  TXMLREPORTType = class;

{ TXMLGatorsAPIType }

  TXMLGatorsAPIType = class(TXMLNode, IXMLGatorsAPIType)
  protected
    { IXMLGatorsAPIType }
    function Get_Order_Data: IXMLOrder_DataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrder_DataType }

  TXMLOrder_DataType = class(TXMLNode, IXMLOrder_DataType)
  protected
    { IXMLOrder_DataType }
    function Get_Customer_Order_Id: WideString;
    function Get_Order_Type: WideString;
    function Get_Appraisal: IXMLAppraisalType;
    function Get_REPORT: IXMLREPORTType;
    procedure Set_Customer_Order_Id(Value: WideString);
    procedure Set_Order_Type(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAppraisalType }

  TXMLAppraisalType = class(TXMLNode, IXMLAppraisalType)
  protected
    { IXMLAppraisalType }
    function Get_LoanNo: WideString;
    function Get_Loan_Desc: WideString;
    function Get_ActualCost: WideString;
    function Get_Appraisal_Code: Integer;
    function Get_ENV_Req: WideString;
    function Get_PropertyAddress: IXMLPropertyAddressType;
    function Get_PropertyId: WideString;
    function Get_Estimated_Value: Integer;
    function Get_Contacts: IXMLContactsType;
    function Get_StructureType: WideString;
    function Get_MarketValue: WideString;
    function Get_Dates: IXMLDatesType;
    function Get_AppraisalInfo: WideString;
    function Get_OrderNotes: IXMLOrderNotesType;
    procedure Set_LoanNo(Value: WideString);
    procedure Set_Loan_Desc(Value: WideString);
    procedure Set_ActualCost(Value: WideString);
    procedure Set_Appraisal_Code(Value: Integer);
    procedure Set_Env_Req(Value: WideString);
    procedure Set_PropertyId(Value: WideString);
    procedure Set_Estimated_Value(Value: Integer);
    procedure Set_StructureType(Value: WideString);
    procedure Set_MarketValue(Value: WideString);
    procedure Set_AppraisalInfo(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPropertyAddressType }

  TXMLPropertyAddressType = class(TXMLNode, IXMLPropertyAddressType)
  protected
    { IXMLPropertyAddressType }
    function Get_StreetAddress: WideString;
    function Get_City: WideString;
    function Get_State: WideString;
    function Get_ZipCode: WideString;
    function Get_County: WideString;
    procedure Set_StreetAddress(Value: WideString);
    procedure Set_City(Value: WideString);
    procedure Set_State(Value: WideString);
    procedure Set_ZipCode(Value: WideString);
    procedure Set_County(Value: WideString);
  end;

{ TXMLContactsType }

  TXMLContactsType = class(TXMLNodeCollection, IXMLContactsType)
  protected
    { IXMLContactsType }
    function Get_Contact(Index: Integer): IXMLContactType;
    function Add: IXMLContactType;
    function Insert(const Index: Integer): IXMLContactType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLContactType }

  TXMLContactType = class(TXMLNode, IXMLContactType)
  protected
    { IXMLContactType }
    function Get_Type_: WideString;
    function Get_ID: WideString;
    function Get_Name: WideString;
    function Get_PhoneNo: WideString;
    function Get_StreetAddress: WideString;
    function Get_City: WideString;
    function Get_State: WideString;
    function Get_ZipCode: WideString;
    function Get_Email_Report_To: WideString;
    function Get_FaxNo: WideString;
    function Get_Contact: WideString;
    function Get_LastName: WideString;
    function Get_MaritalStatus: WideString;
    procedure Set_Type_(Value: WideString);
    procedure Set_ID(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_PhoneNo(Value: WideString);
    procedure Set_StreetAddress(Value: WideString);
    procedure Set_City(Value: WideString);
    procedure Set_State(Value: WideString);
    procedure Set_ZipCode(Value: WideString);
    procedure Set_Email_Report_To(Value: WideString);
    procedure Set_FaxNo(Value: WideString);
    procedure Set_Contact(Value: WideString);
    procedure Set_LastName(Value: WideString);
    procedure Set_MaritalStatus(Value: WideString);
  end;

{ TXMLDatesType }

  TXMLDatesType = class(TXMLNode, IXMLDatesType)
  protected
    { IXMLDatesType }
    function Get_OrderedDate: WideString;
    function Get_ProjAppointmentDate: WideString;
    function Get_ActlAppointmentDate: WideString;
    function Get_ProjHardcopyDate: WideString;
    function Get_ActlHardcopyDate: WideString;
    procedure Set_OrderedDate(Value: WideString);
    procedure Set_ProjAppointmentDate(Value: WideString);
    procedure Set_ActlAppointmentDate(Value: WideString);
    procedure Set_ProjHardcopyDate(Value: WideString);
    procedure Set_ActlHardcopyDate(Value: WideString);
  end;

{ TXMLOrderNotesType }

  TXMLOrderNotesType = class(TXMLNodeCollection, IXMLOrderNotesType)
  protected
    { IXMLOrderNotesType }
    function Get_OrderNote(Index: Integer): IXMLOrderNoteType;
    function Add: IXMLOrderNoteType;
    function Insert(const Index: Integer): IXMLOrderNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrderNoteType }

  TXMLOrderNoteType = class(TXMLNode, IXMLOrderNoteType)
  protected
    { IXMLOrderNoteType }
    function Get_NoteDate: WideString;
    function Get_UserId: WideString;
    function Get_NoteTypeCode: Integer;
    function Get_NoteTypeText: WideString;
    function Get_Notes: WideString;
    function Get_MiscItems: IXMLMiscItemsType;
    procedure Set_NoteDate(Value: WideString);
    procedure Set_UserId(Value: WideString);
    procedure Set_NoteTypeCode(Value: Integer);
    procedure Set_NoteTypeText(Value: WideString);
    procedure Set_Notes(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMiscItemsType }

  TXMLMiscItemsType = class(TXMLNodeCollection, IXMLMiscItemsType)
  protected
    { IXMLMiscItemsType }
    function Get_MiscItem(Index: Integer): IXMLMiscItemType;
    function Add: IXMLMiscItemType;
    function Insert(const Index: Integer): IXMLMiscItemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMiscItemType }

  TXMLMiscItemType = class(TXMLNode, IXMLMiscItemType)
  protected
    { IXMLMiscItemType }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
  end;

{ TXMLREPORTType }

  TXMLREPORTType = class(TXMLNode, IXMLREPORTType)
  protected
    { IXMLREPORTType }
    function Get_DESCRIPTION: WideString;
    function Get_FILENUM: WideString;
    function Get_MAJORFORM: Integer;
    function Get_VERSION: WideString;
    procedure Set_DESCRIPTION(Value: WideString);
    procedure Set_FILENUM(Value: WideString);
    procedure Set_MAJORFORM(Value: Integer);
    procedure Set_VERSION(Value: WideString);
  end;

{ Global Functions }

function GetGatorsAPI(Doc: IXMLDocument): IXMLGatorsAPIType;
function LoadGatorsAPI(const FileName: WideString): IXMLGatorsAPIType;
function LoadGatorsAPIData(const APIData: WideString): IXMLGatorsAPIType;
function NewGatorsAPI: IXMLGatorsAPIType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetGatorsAPI(Doc: IXMLDocument): IXMLGatorsAPIType;
begin
  Result := Doc.GetDocBinding('GatorsAPI', TXMLGatorsAPIType, TargetNamespace) as IXMLGatorsAPIType;
end;

function LoadGatorsAPI(const FileName: WideString): IXMLGatorsAPIType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('GatorsAPI', TXMLGatorsAPIType, TargetNamespace) as IXMLGatorsAPIType;
end;

function LoadGatorsAPIData(const APIData: WideString): IXMLGatorsAPIType;
begin
  Result := LoadXMLData(APIData).GetDocBinding('GatorsAPI', TXMLGatorsAPIType, TargetNamespace) as IXMLGatorsAPIType;
end;

function NewGatorsAPI: IXMLGatorsAPIType;
begin
  Result := NewXMLDocument.GetDocBinding('GatorsAPI', TXMLGatorsAPIType, TargetNamespace) as IXMLGatorsAPIType;
end;

{ TXMLGatorsAPIType }

procedure TXMLGatorsAPIType.AfterConstruction;
begin
  RegisterChildNode('Order_Data', TXMLOrder_DataType);
  inherited;
end;

function TXMLGatorsAPIType.Get_Order_Data: IXMLOrder_DataType;
begin
  Result := ChildNodes['Order_Data'] as IXMLOrder_DataType;
end;

{ TXMLOrder_DataType }

procedure TXMLOrder_DataType.AfterConstruction;
begin
  RegisterChildNode('Appraisal', TXMLAppraisalType);
  RegisterChildNode('REPORT', TXMLREPORTType);
  inherited;
end;

function TXMLOrder_DataType.Get_Customer_Order_Id: WideString;
begin
  Result := ChildNodes['Customer_Order_Id'].Text;
end;

procedure TXMLOrder_DataType.Set_Customer_Order_Id(Value: WideString);
begin
  ChildNodes['Customer_Order_Id'].NodeValue := Value;
end;

function TXMLOrder_DataType.Get_Order_Type: WideString;
begin
  Result := ChildNodes['Order_Type'].Text;
end;

procedure TXMLOrder_DataType.Set_Order_Type(Value: WideString);
begin
  ChildNodes['Order_Type'].NodeValue := Value;
end;

function TXMLOrder_DataType.Get_Appraisal: IXMLAppraisalType;
begin
  Result := ChildNodes['Appraisal'] as IXMLAppraisalType;
end;

function TXMLOrder_DataType.Get_REPORT: IXMLREPORTType;
begin
  Result := ChildNodes['REPORT'] as IXMLREPORTType;
end;

{ TXMLAppraisalType }

procedure TXMLAppraisalType.AfterConstruction;
begin
  RegisterChildNode('PropertyAddress', TXMLPropertyAddressType);
  RegisterChildNode('Contacts', TXMLContactsType);
  RegisterChildNode('Dates', TXMLDatesType);
  RegisterChildNode('OrderNotes', TXMLOrderNotesType);
  inherited;
end;

function TXMLAppraisalType.Get_LoanNo: WideString;
begin
  Result := ChildNodes['LoanNo'].Text;
end;

procedure TXMLAppraisalType.Set_LoanNo(Value: WideString);
begin
  ChildNodes['LoanNo'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_Loan_Desc: WideString;
begin
  Result := ChildNodes['Loan_Desc'].Text;
end;

procedure TXMLAppraisalType.Set_Loan_Desc(Value: WideString);
begin
  ChildNodes['Loan_Desc'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_ActualCost: WideString;
begin
  Result := ChildNodes['ActualCost'].Text;
end;

procedure TXMLAppraisalType.Set_ActualCost(Value: WideString);
begin
  ChildNodes['ActualCost'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_Appraisal_Code: Integer;
begin
  Result := ChildNodes['Appraisal_Code'].NodeValue;
end;

procedure TXMLAppraisalType.Set_Appraisal_Code(Value: Integer);
begin
  ChildNodes['Appraisal_Code'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_ENV_Req: WideString;
begin
  Result := ChildNodes['ENV_Req'].Text;
end;

procedure TXMLAppraisalType.Set_ENV_Req(Value: WideString);
begin
  ChildNodes['ENV_Req'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_PropertyAddress: IXMLPropertyAddressType;
begin
  Result := ChildNodes['PropertyAddress'] as IXMLPropertyAddressType;
end;

function TXMLAppraisalType.Get_PropertyId: WideString;
begin
  Result := ChildNodes['PropertyId'].Text;
end;

procedure TXMLAppraisalType.Set_PropertyId(Value: WideString);
begin
  ChildNodes['PropertyId'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_Estimated_Value: Integer;
begin
  Result := ChildNodes['Estimated_Value'].NodeValue;
end;

procedure TXMLAppraisalType.Set_Estimated_Value(Value: Integer);
begin
  ChildNodes['Estimated_Value'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_Contacts: IXMLContactsType;
begin
  Result := ChildNodes['Contacts'] as IXMLContactsType;
end;

function TXMLAppraisalType.Get_StructureType: WideString;
begin
  Result := ChildNodes['StructureType'].Text;
end;

procedure TXMLAppraisalType.Set_StructureType(Value: WideString);
begin
  ChildNodes['StructureType'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_MarketValue: WideString;
begin
  Result := ChildNodes['MarketValue'].Text;
end;

procedure TXMLAppraisalType.Set_MarketValue(Value: WideString);
begin
  ChildNodes['MarketValue'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_Dates: IXMLDatesType;
begin
  Result := ChildNodes['Dates'] as IXMLDatesType;
end;

function TXMLAppraisalType.Get_AppraisalInfo: WideString;
begin
  Result := ChildNodes['AppraisalInfo'].Text;
end;

procedure TXMLAppraisalType.Set_AppraisalInfo(Value: WideString);
begin
  ChildNodes['AppraisalInfo'].NodeValue := Value;
end;

function TXMLAppraisalType.Get_OrderNotes: IXMLOrderNotesType;
begin
  Result := ChildNodes['OrderNotes'] as IXMLOrderNotesType;
end;

{ TXMLPropertyAddressType }

function TXMLPropertyAddressType.Get_StreetAddress: WideString;
begin
  Result := ChildNodes['StreetAddress'].Text;
end;

procedure TXMLPropertyAddressType.Set_StreetAddress(Value: WideString);
begin
  ChildNodes['StreetAddress'].NodeValue := Value;
end;

function TXMLPropertyAddressType.Get_City: WideString;
begin
  Result := ChildNodes['City'].Text;
end;

procedure TXMLPropertyAddressType.Set_City(Value: WideString);
begin
  ChildNodes['City'].NodeValue := Value;
end;

function TXMLPropertyAddressType.Get_State: WideString;
begin
  Result := ChildNodes['State'].Text;
end;

procedure TXMLPropertyAddressType.Set_State(Value: WideString);
begin
  ChildNodes['State'].NodeValue := Value;
end;

function TXMLPropertyAddressType.Get_ZipCode: WideString;
begin
  Result := ChildNodes['ZipCode'].Text;
end;

procedure TXMLPropertyAddressType.Set_ZipCode(Value: WideString);
begin
  ChildNodes['ZipCode'].NodeValue := Value;
end;

function TXMLPropertyAddressType.Get_County: WideString;
begin
  Result := ChildNodes['County'].Text;
end;

procedure TXMLPropertyAddressType.Set_County(Value: WideString);
begin
  ChildNodes['County'].NodeValue := Value;
end;

{ TXMLContactsType }

procedure TXMLContactsType.AfterConstruction;
begin
  RegisterChildNode('Contact', TXMLContactType);
  ItemTag := 'Contact';
  ItemInterface := IXMLContactType;
  inherited;
end;

function TXMLContactsType.Get_Contact(Index: Integer): IXMLContactType;
begin
  Result := List[Index] as IXMLContactType;
end;

function TXMLContactsType.Add: IXMLContactType;
begin
  Result := AddItem(-1) as IXMLContactType;
end;

function TXMLContactsType.Insert(const Index: Integer): IXMLContactType;
begin
  Result := AddItem(Index) as IXMLContactType;
end;

{ TXMLContactType }

function TXMLContactType.Get_Type_: WideString;
begin
  Result := ChildNodes['Type'].Text;
end;

procedure TXMLContactType.Set_Type_(Value: WideString);
begin
  ChildNodes['Type'].NodeValue := Value;
end;

function TXMLContactType.Get_ID: WideString;
begin
  Result := ChildNodes['ID'].Text;
end;

procedure TXMLContactType.Set_ID(Value: WideString);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLContactType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLContactType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLContactType.Get_PhoneNo: WideString;
begin
  Result := ChildNodes['PhoneNo'].Text;
end;

procedure TXMLContactType.Set_PhoneNo(Value: WideString);
begin
  ChildNodes['PhoneNo'].NodeValue := Value;
end;

function TXMLContactType.Get_StreetAddress: WideString;
begin
  Result := ChildNodes['StreetAddress'].Text;
end;

procedure TXMLContactType.Set_StreetAddress(Value: WideString);
begin
  ChildNodes['StreetAddress'].NodeValue := Value;
end;

function TXMLContactType.Get_City: WideString;
begin
  Result := ChildNodes['City'].Text;
end;

procedure TXMLContactType.Set_City(Value: WideString);
begin
  ChildNodes['City'].NodeValue := Value;
end;

function TXMLContactType.Get_State: WideString;
begin
  Result := ChildNodes['State'].Text;
end;

procedure TXMLContactType.Set_State(Value: WideString);
begin
  ChildNodes['State'].NodeValue := Value;
end;

function TXMLContactType.Get_ZipCode: WideString;
begin
  Result := ChildNodes['ZipCode'].Text;
end;

procedure TXMLContactType.Set_ZipCode(Value: WideString);
begin
  ChildNodes['ZipCode'].NodeValue := Value;
end;

function TXMLContactType.Get_Email_Report_To: WideString;
begin
  Result := ChildNodes['Email_Report_To'].Text;
end;

procedure TXMLContactType.Set_Email_Report_To(Value: WideString);
begin
  ChildNodes['Email_Report_To'].NodeValue := Value;
end;

function TXMLContactType.Get_FaxNo: WideString;
begin
  Result := ChildNodes['FaxNo'].Text;
end;

procedure TXMLContactType.Set_FaxNo(Value: WideString);
begin
  ChildNodes['FaxNo'].NodeValue := Value;
end;

function TXMLContactType.Get_Contact: WideString;
begin
  Result := ChildNodes['Contact'].Text;
end;

procedure TXMLContactType.Set_Contact(Value: WideString);
begin
  ChildNodes['Contact'].NodeValue := Value;
end;

function TXMLContactType.Get_LastName: WideString;
begin
  Result := ChildNodes['LastName'].Text;
end;

procedure TXMLContactType.Set_LastName(Value: WideString);
begin
  ChildNodes['LastName'].NodeValue := Value;
end;

function TXMLContactType.Get_MaritalStatus: WideString;
begin
  Result := ChildNodes['MaritalStatus'].Text;
end;

procedure TXMLContactType.Set_MaritalStatus(Value: WideString);
begin
  ChildNodes['MaritalStatus'].NodeValue := Value;
end;

{ TXMLDatesType }

function TXMLDatesType.Get_OrderedDate: WideString;
begin
  Result := ChildNodes['OrderedDate'].Text;
end;

procedure TXMLDatesType.Set_OrderedDate(Value: WideString);
begin
  ChildNodes['OrderedDate'].NodeValue := Value;
end;

function TXMLDatesType.Get_ProjAppointmentDate: WideString;
begin
  Result := ChildNodes['ProjAppointmentDate'].Text;
end;

procedure TXMLDatesType.Set_ProjAppointmentDate(Value: WideString);
begin
  ChildNodes['ProjAppointmentDate'].NodeValue := Value;
end;

function TXMLDatesType.Get_ActlAppointmentDate: WideString;
begin
  Result := ChildNodes['ActlAppointmentDate'].Text;
end;

procedure TXMLDatesType.Set_ActlAppointmentDate(Value: WideString);
begin
  ChildNodes['ActlAppointmentDate'].NodeValue := Value;
end;

function TXMLDatesType.Get_ProjHardcopyDate: WideString;
begin
  Result := ChildNodes['ProjHardcopyDate'].Text;
end;

procedure TXMLDatesType.Set_ProjHardcopyDate(Value: WideString);
begin
  ChildNodes['ProjHardcopyDate'].NodeValue := Value;
end;

function TXMLDatesType.Get_ActlHardcopyDate: WideString;
begin
  Result := ChildNodes['ActlHardcopyDate'].Text;
end;

procedure TXMLDatesType.Set_ActlHardcopyDate(Value: WideString);
begin
  ChildNodes['ActlHardcopyDate'].NodeValue := Value;
end;

{ TXMLOrderNotesType }

procedure TXMLOrderNotesType.AfterConstruction;
begin
  RegisterChildNode('OrderNote', TXMLOrderNoteType);
  ItemTag := 'OrderNote';
  ItemInterface := IXMLOrderNoteType;
  inherited;
end;

function TXMLOrderNotesType.Get_OrderNote(Index: Integer): IXMLOrderNoteType;
begin
  Result := List[Index] as IXMLOrderNoteType;
end;

function TXMLOrderNotesType.Add: IXMLOrderNoteType;
begin
  Result := AddItem(-1) as IXMLOrderNoteType;
end;

function TXMLOrderNotesType.Insert(const Index: Integer): IXMLOrderNoteType;
begin
  Result := AddItem(Index) as IXMLOrderNoteType;
end;

{ TXMLOrderNoteType }

procedure TXMLOrderNoteType.AfterConstruction;
begin
  RegisterChildNode('MiscItems', TXMLMiscItemsType);
  inherited;
end;

function TXMLOrderNoteType.Get_NoteDate: WideString;
begin
  Result := ChildNodes['NoteDate'].Text;
end;

procedure TXMLOrderNoteType.Set_NoteDate(Value: WideString);
begin
  ChildNodes['NoteDate'].NodeValue := Value;
end;

function TXMLOrderNoteType.Get_UserId: WideString;
begin
  Result := ChildNodes['UserId'].Text;
end;

procedure TXMLOrderNoteType.Set_UserId(Value: WideString);
begin
  ChildNodes['UserId'].NodeValue := Value;
end;

function TXMLOrderNoteType.Get_NoteTypeCode: Integer;
begin
  Result := ChildNodes['NoteTypeCode'].NodeValue;
end;

procedure TXMLOrderNoteType.Set_NoteTypeCode(Value: Integer);
begin
  ChildNodes['NoteTypeCode'].NodeValue := Value;
end;

function TXMLOrderNoteType.Get_NoteTypeText: WideString;
begin
  Result := ChildNodes['NoteTypeText'].Text;
end;

procedure TXMLOrderNoteType.Set_NoteTypeText(Value: WideString);
begin
  ChildNodes['NoteTypeText'].NodeValue := Value;
end;

function TXMLOrderNoteType.Get_Notes: WideString;
begin
  Result := ChildNodes['Notes'].Text;
end;

procedure TXMLOrderNoteType.Set_Notes(Value: WideString);
begin
  ChildNodes['Notes'].NodeValue := Value;
end;

function TXMLOrderNoteType.Get_MiscItems: IXMLMiscItemsType;
begin
  Result := ChildNodes['MiscItems'] as IXMLMiscItemsType;
end;

{ TXMLMiscItemsType }

procedure TXMLMiscItemsType.AfterConstruction;
begin
  RegisterChildNode('MiscItem', TXMLMiscItemType);
  ItemTag := 'MiscItem';
  ItemInterface := IXMLMiscItemType;
  inherited;
end;

function TXMLMiscItemsType.Get_MiscItem(Index: Integer): IXMLMiscItemType;
begin
  Result := List[Index] as IXMLMiscItemType;
end;

function TXMLMiscItemsType.Add: IXMLMiscItemType;
begin
  Result := AddItem(-1) as IXMLMiscItemType;
end;

function TXMLMiscItemsType.Insert(const Index: Integer): IXMLMiscItemType;
begin
  Result := AddItem(Index) as IXMLMiscItemType;
end;

{ TXMLMiscItemType }

function TXMLMiscItemType.Get_Name: WideString;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TXMLMiscItemType.Set_Name(Value: WideString);
begin
  SetAttribute('Name', Value);
end;

{ TXMLREPORTType }

function TXMLREPORTType.Get_DESCRIPTION: WideString;
begin
  Result := AttributeNodes['DESCRIPTION'].Text;
end;

procedure TXMLREPORTType.Set_DESCRIPTION(Value: WideString);
begin
  SetAttribute('DESCRIPTION', Value);
end;

function TXMLREPORTType.Get_FILENUM: WideString;
begin
  Result := AttributeNodes['FILENUM'].Text;
end;

procedure TXMLREPORTType.Set_FILENUM(Value: WideString);
begin
  SetAttribute('FILENUM', Value);
end;

function TXMLREPORTType.Get_MAJORFORM: Integer;
begin
  Result := AttributeNodes['MAJORFORM'].NodeValue;
end;

procedure TXMLREPORTType.Set_MAJORFORM(Value: Integer);
begin
  SetAttribute('MAJORFORM', Value);
end;

function TXMLREPORTType.Get_VERSION: WideString;
begin
  Result := AttributeNodes['VERSION'].Text;
end;

procedure TXMLREPORTType.Set_VERSION(Value: WideString);
begin
  SetAttribute('VERSION', Value);
end;

end.